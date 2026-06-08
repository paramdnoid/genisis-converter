import {
  CanActivate,
  ExecutionContext,
  ForbiddenException,
  Injectable,
  UnauthorizedException,
} from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import { Reflector } from "@nestjs/core";
import { JwtService } from "@nestjs/jwt";

import { IS_PUBLIC_ROUTE } from "../decorators/public.decorator";
import { AuthenticatedRequest, RequestUser } from "../types/request-user";

interface TokenPayload {
  sub: string;
  tenantId: string;
  email: string;
  role: string;
  typ: "access" | "refresh";
}

@Injectable()
export class JwtAuthGuard implements CanActivate {
  constructor(
    private readonly reflector: Reflector,
    private readonly jwt: JwtService,
    private readonly config: ConfigService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const isPublic = this.reflector.getAllAndOverride<boolean>(
      IS_PUBLIC_ROUTE,
      [context.getHandler(), context.getClass()],
    );
    if (isPublic) {
      return true;
    }

    const request = context.switchToHttp().getRequest<AuthenticatedRequest>();
    const token = this.readBearerToken(request);
    if (!token) {
      throw new UnauthorizedException("Missing bearer token.");
    }

    const payload = await this.verifyAccessToken(token);
    const requestedTenant = request.headers["x-tenant-id"]?.toString();
    if (requestedTenant && requestedTenant !== payload.tenantId) {
      throw new ForbiddenException(
        "Requested tenant does not match token tenant.",
      );
    }

    request.user = {
      id: payload.sub,
      tenantId: payload.tenantId,
      email: payload.email,
      role: payload.role,
    } satisfies RequestUser;
    request.tenantId = requestedTenant ?? payload.tenantId;

    return true;
  }

  private readBearerToken(request: AuthenticatedRequest): string | undefined {
    const header = request.headers.authorization;
    if (!header) {
      return undefined;
    }

    const [scheme, token] = header.split(" ");
    if (scheme?.toLowerCase() !== "bearer" || !token) {
      return undefined;
    }
    return token;
  }

  private async verifyAccessToken(token: string): Promise<TokenPayload> {
    try {
      const payload = await this.jwt.verifyAsync<TokenPayload>(token, {
        issuer: this.config.get<string>("JWT_ISSUER"),
        secret: this.config.get<string>("JWT_ACCESS_SECRET"),
      });
      if (payload.typ !== "access") {
        throw new UnauthorizedException(
          "Refresh token cannot access API routes.",
        );
      }
      return payload;
    } catch (error) {
      if (error instanceof UnauthorizedException) {
        throw error;
      }
      throw new UnauthorizedException("Invalid or expired access token.");
    }
  }
}
