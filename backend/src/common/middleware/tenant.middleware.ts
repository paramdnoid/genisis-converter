import { ForbiddenException, Injectable, NestMiddleware } from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import { JwtService } from "@nestjs/jwt";
import { NextFunction, Response } from "express";

import { AuthenticatedRequest } from "../types/request-user";

interface TokenTenantPayload {
  tenantId?: string;
}

@Injectable()
export class TenantMiddleware implements NestMiddleware {
  constructor(
    private readonly jwt: JwtService,
    private readonly config: ConfigService,
  ) {}

  use(request: AuthenticatedRequest, _response: Response, next: NextFunction) {
    const requestedTenant = request.headers["x-tenant-id"]?.toString();
    const tokenTenant = this.readTokenTenant(request);

    if (requestedTenant && tokenTenant && requestedTenant !== tokenTenant) {
      throw new ForbiddenException(
        "Tenant header does not match bearer token.",
      );
    }

    request.tenantId = requestedTenant ?? tokenTenant;
    next();
  }

  private readTokenTenant(request: AuthenticatedRequest): string | undefined {
    const header = request.headers.authorization;
    if (!header) {
      return undefined;
    }

    const [scheme, token] = header.split(" ");
    if (scheme?.toLowerCase() !== "bearer" || !token) {
      return undefined;
    }

    try {
      const payload = this.jwt.verify<TokenTenantPayload>(token, {
        issuer: this.config.get<string>("JWT_ISSUER"),
        secret: this.config.get<string>("JWT_ACCESS_SECRET"),
      });
      return payload.tenantId;
    } catch {
      return undefined;
    }
  }
}
