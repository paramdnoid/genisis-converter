import { BadRequestException, Injectable, Logger } from "@nestjs/common";
import { Prisma } from "@prisma/client";

import { RequestUser } from "../common/types/request-user";
import { PrismaService } from "../prisma/prisma.service";
import { FirebasePushGateway, PushGatewayResult } from "./push.gateway";

export interface RegisterPushDeviceTokenRequest {
  token?: string;
  platform?: string;
  deviceId?: string;
  appVersion?: string;
}

export interface NotifyWorkOrderResult {
  workOrderId: string;
  targetUserId: string | null;
  tokenCount: number;
  successCount: number;
  failureCount: number;
  disabled: boolean;
  reason?: string;
}

type WorkOrderForPush = Prisma.WorkOrderGetPayload<{
  include: {
    customer: true;
    object: true;
  };
}>;

const SUPPORTED_PLATFORMS = new Set(["android", "ios", "web"]);

@Injectable()
export class PushService {
  private readonly logger = new Logger(PushService.name);

  constructor(
    private readonly prisma: PrismaService,
    private readonly gateway: FirebasePushGateway,
  ) {}

  async registerDeviceToken(
    tenantId: string,
    user: RequestUser,
    body: RegisterPushDeviceTokenRequest,
  ) {
    const token = requiredString(body.token, "token");
    const platform = normalizePlatform(body.platform);
    const deviceId = optionalString(body.deviceId);
    const appVersion = optionalString(body.appVersion);
    const now = new Date();

    return this.prisma.pushDeviceToken.upsert({
      where: {
        tenantId_token: {
          tenantId,
          token,
        },
      },
      update: {
        userId: user.id,
        platform,
        deviceId,
        appVersion,
        revokedAt: null,
        lastSeenAt: now,
      },
      create: {
        tenantId,
        userId: user.id,
        token,
        platform,
        deviceId,
        appVersion,
        lastSeenAt: now,
      },
      select: {
        id: true,
        tenantId: true,
        userId: true,
        platform: true,
        deviceId: true,
        appVersion: true,
        lastSeenAt: true,
        revokedAt: true,
      },
    });
  }

  async revokeDeviceToken(
    tenantId: string,
    user: RequestUser,
    body: Pick<RegisterPushDeviceTokenRequest, "token">,
  ) {
    const token = requiredString(body.token, "token");
    const result = await this.prisma.pushDeviceToken.updateMany({
      where: {
        tenantId,
        userId: user.id,
        token,
        revokedAt: null,
      },
      data: {
        revokedAt: new Date(),
      },
    });

    return { revoked: result.count };
  }

  async notifyNewWorkOrder(
    tenantId: string,
    workOrderId: string,
    options: { previousAssignedUserId?: string | null } = {},
  ): Promise<NotifyWorkOrderResult> {
    const workOrder = await this.prisma.workOrder.findFirst({
      where: { id: workOrderId, tenantId, deletedAt: null },
      include: {
        customer: true,
        object: true,
      },
    });

    if (!workOrder) {
      return emptyResult(workOrderId, null, "work_order_missing");
    }
    if (!workOrder.assignedUserId) {
      return emptyResult(workOrderId, null, "work_order_unassigned");
    }
    if (options.previousAssignedUserId === workOrder.assignedUserId) {
      return emptyResult(
        workOrderId,
        workOrder.assignedUserId,
        "assignment_unchanged",
      );
    }

    const tokens = await this.activeTokens(tenantId, workOrder.assignedUserId);
    if (tokens.length === 0) {
      await this.auditDelivery(tenantId, workOrder, {
        successCount: 0,
        failureCount: 0,
        invalidTokens: [],
        disabled: false,
      });
      return emptyResult(workOrderId, workOrder.assignedUserId, "no_tokens");
    }

    try {
      const delivery = await this.gateway.send({
        tokens,
        title: `Neuer Auftrag ${workOrder.orderNumber}`,
        body: notificationBody(workOrder),
        data: notificationData(workOrder),
      });
      if (delivery.invalidTokens.length > 0) {
        await this.revokeInvalidTokens(tenantId, delivery.invalidTokens);
      }
      await this.auditDelivery(tenantId, workOrder, delivery);

      return {
        workOrderId,
        targetUserId: workOrder.assignedUserId,
        tokenCount: tokens.length,
        successCount: delivery.successCount,
        failureCount: delivery.failureCount,
        disabled: delivery.disabled,
        reason: delivery.disabled ? "gateway_disabled" : undefined,
      };
    } catch (error) {
      this.logger.warn(
        `Failed to deliver work-order push ${workOrder.id}: ${
          error instanceof Error ? error.message : String(error)
        }`,
      );
      return {
        workOrderId,
        targetUserId: workOrder.assignedUserId,
        tokenCount: tokens.length,
        successCount: 0,
        failureCount: tokens.length,
        disabled: false,
        reason: "gateway_error",
      };
    }
  }

  async queueNewWorkOrderNotification(
    tenantId: string,
    workOrderId: string,
    options: { previousAssignedUserId?: string | null } = {},
  ) {
    void this.notifyNewWorkOrder(tenantId, workOrderId, options);
  }

  private async activeTokens(tenantId: string, userId: string) {
    const records = await this.prisma.pushDeviceToken.findMany({
      where: {
        tenantId,
        userId,
        revokedAt: null,
        user: {
          isActive: true,
          deletedAt: null,
        },
      },
      select: { token: true },
    });

    return records.map((record) => record.token);
  }

  private async revokeInvalidTokens(tenantId: string, tokens: string[]) {
    await this.prisma.pushDeviceToken.updateMany({
      where: {
        tenantId,
        token: { in: tokens },
        revokedAt: null,
      },
      data: {
        revokedAt: new Date(),
      },
    });
  }

  private async auditDelivery(
    tenantId: string,
    workOrder: WorkOrderForPush,
    delivery: PushGatewayResult,
  ) {
    await this.prisma.auditLog.create({
      data: {
        tenantId,
        userId: workOrder.assignedUserId,
        action: "push_new_work_order",
        entityType: "work_order",
        entityId: workOrder.id,
        metadata: {
          orderNumber: workOrder.orderNumber,
          successCount: delivery.successCount,
          failureCount: delivery.failureCount,
          disabled: delivery.disabled,
          invalidTokenCount: delivery.invalidTokens.length,
        },
      },
    });
  }
}

function requiredString(value: unknown, field: string) {
  const trimmed = value?.toString().trim() ?? "";
  if (!trimmed) {
    throw new BadRequestException(`${field} is required.`);
  }
  if (trimmed.length > 4096) {
    throw new BadRequestException(`${field} is too long.`);
  }
  return trimmed;
}

function optionalString(value: unknown) {
  const trimmed = value?.toString().trim() ?? "";
  return trimmed || null;
}

function normalizePlatform(value: unknown) {
  const platform = value?.toString().trim().toLowerCase() ?? "";
  if (!SUPPORTED_PLATFORMS.has(platform)) {
    throw new BadRequestException(
      "platform must be one of android, ios or web.",
    );
  }
  return platform;
}

function notificationBody(workOrder: WorkOrderForPush) {
  const startsAt = workOrder.scheduledStart
    ? ` · ${workOrder.scheduledStart.toISOString()}`
    : "";
  return `${workOrder.title} · ${workOrder.customer.displayName}${startsAt}`;
}

function notificationData(workOrder: WorkOrderForPush) {
  return {
    type: "new_work_order",
    workOrderId: workOrder.id,
    orderNumber: workOrder.orderNumber,
    title: workOrder.title,
    customerName: workOrder.customer.displayName,
    objectName: workOrder.object.name,
    scheduledStart: workOrder.scheduledStart?.toISOString() ?? "",
  };
}

function emptyResult(
  workOrderId: string,
  targetUserId: string | null,
  reason: string,
): NotifyWorkOrderResult {
  return {
    workOrderId,
    targetUserId,
    tokenCount: 0,
    successCount: 0,
    failureCount: 0,
    disabled: false,
    reason,
  };
}
