import { Injectable, Logger } from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import {
  applicationDefault,
  cert,
  getApps,
  initializeApp,
} from "firebase-admin/app";
import { getMessaging, Messaging } from "firebase-admin/messaging";

export interface PushGatewayMessage {
  tokens: string[];
  title: string;
  body: string;
  data: Record<string, string>;
}

export interface PushGatewayResult {
  successCount: number;
  failureCount: number;
  invalidTokens: string[];
  disabled: boolean;
}

const FIREBASE_APP_NAME = "kaminfeger-push";
const FCM_BATCH_SIZE = 500;

@Injectable()
export class FirebasePushGateway {
  private readonly logger = new Logger(FirebasePushGateway.name);
  private messaging: Messaging | null | undefined;

  constructor(private readonly config: ConfigService) {}

  async send(message: PushGatewayMessage): Promise<PushGatewayResult> {
    const tokens = [...new Set(message.tokens.map((token) => token.trim()))]
      .filter(Boolean)
      .slice(0, 5000);
    if (tokens.length === 0) {
      return {
        successCount: 0,
        failureCount: 0,
        invalidTokens: [],
        disabled: false,
      };
    }

    const messaging = this.messagingClient();
    if (!messaging) {
      return {
        successCount: 0,
        failureCount: 0,
        invalidTokens: [],
        disabled: true,
      };
    }

    let successCount = 0;
    let failureCount = 0;
    const invalidTokens = new Set<string>();

    for (const batch of chunks(tokens, FCM_BATCH_SIZE)) {
      const response = await messaging.sendEachForMulticast({
        tokens: batch,
        notification: {
          title: message.title,
          body: message.body,
        },
        data: message.data,
      });
      successCount += response.successCount;
      failureCount += response.failureCount;

      response.responses.forEach((result, index) => {
        if (!result.success && isInvalidTokenError(result.error?.code)) {
          invalidTokens.add(batch[index]);
        }
      });
    }

    return {
      successCount,
      failureCount,
      invalidTokens: [...invalidTokens],
      disabled: false,
    };
  }

  private messagingClient() {
    if (this.messaging !== undefined) {
      return this.messaging;
    }

    if (!this.isConfigured()) {
      this.messaging = null;
      return null;
    }

    try {
      const existing = getApps().find((app) => app.name === FIREBASE_APP_NAME);
      const app =
        existing ??
        initializeApp(
          {
            credential: this.credential(),
            projectId: this.config.get<string>("FIREBASE_PROJECT_ID"),
          },
          FIREBASE_APP_NAME,
        );
      this.messaging = getMessaging(app);
      return this.messaging;
    } catch (error) {
      this.logger.warn(
        `Firebase push gateway disabled: ${
          error instanceof Error ? error.message : String(error)
        }`,
      );
      this.messaging = null;
      return null;
    }
  }

  private credential() {
    const projectId = this.config.get<string>("FIREBASE_PROJECT_ID");
    const clientEmail = this.config.get<string>("FIREBASE_CLIENT_EMAIL");
    const privateKey = this.config.get<string>("FIREBASE_PRIVATE_KEY");

    if (projectId && clientEmail && privateKey) {
      return cert({
        projectId,
        clientEmail,
        privateKey: privateKey.replace(/\\n/g, "\n"),
      });
    }

    return applicationDefault();
  }

  private isConfigured() {
    const explicit = this.config.get<string>("PUSH_NOTIFICATIONS_ENABLED");
    if (explicit?.trim().toLowerCase() === "false") {
      return false;
    }
    if (explicit?.trim().toLowerCase() === "true") {
      return true;
    }

    return Boolean(
      this.config.get<string>("GOOGLE_APPLICATION_CREDENTIALS") ||
      this.config.get<string>("FIREBASE_PROJECT_ID"),
    );
  }
}

function chunks<T>(items: T[], size: number) {
  const batches: T[][] = [];
  for (let index = 0; index < items.length; index += size) {
    batches.push(items.slice(index, index + size));
  }
  return batches;
}

function isInvalidTokenError(code?: string) {
  return (
    code === "messaging/invalid-registration-token" ||
    code === "messaging/registration-token-not-registered"
  );
}
