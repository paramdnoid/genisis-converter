import { Injectable, UnauthorizedException } from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import { JwtService, JwtSignOptions } from "@nestjs/jwt";
import { compare } from "bcryptjs";

import { RequestUser } from "../common/types/request-user";
import { PrismaService } from "../prisma/prisma.service";

export interface LoginRequest {
  email?: string;
  password?: string;
}

export interface RefreshRequest {
  refreshToken?: string;
}

interface TokenPayload {
  sub: string;
  tenantId: string;
  email: string;
  role: string;
  typ: "access" | "refresh";
}

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
    private readonly config: ConfigService,
  ) {}

  async login(request: LoginRequest) {
    const email = request.email?.trim().toLowerCase();
    const password = request.password ?? "";
    if (!email || !password) {
      throw new UnauthorizedException("Email and password are required.");
    }

    const user = await this.prisma.user.findFirst({
      where: {
        email,
        isActive: true,
        deletedAt: null,
      },
      include: { tenant: true },
    });
    if (!user || !(await compare(password, user.passwordHash))) {
      throw new UnauthorizedException("Invalid credentials.");
    }

    return {
      user: this.toPublicUser(user),
      tenant: user.tenant,
      tokens: await this.issueTokens({
        sub: user.id,
        tenantId: user.tenantId,
        email: user.email,
        role: user.role,
      }),
    };
  }

  async refresh(request: RefreshRequest) {
    if (!request.refreshToken) {
      throw new UnauthorizedException("Refresh token is required.");
    }

    let payload: TokenPayload;
    try {
      payload = await this.jwt.verifyAsync<TokenPayload>(request.refreshToken, {
        issuer: this.config.get<string>("JWT_ISSUER"),
        secret: this.config.get<string>("JWT_REFRESH_SECRET"),
      });
    } catch {
      throw new UnauthorizedException("Invalid or expired refresh token.");
    }

    if (payload.typ !== "refresh") {
      throw new UnauthorizedException("Access token cannot be refreshed.");
    }

    const user = await this.prisma.user.findFirst({
      where: {
        id: payload.sub,
        tenantId: payload.tenantId,
        isActive: true,
        deletedAt: null,
      },
    });
    if (!user) {
      throw new UnauthorizedException(
        "Refresh session user is no longer active.",
      );
    }

    return {
      tokens: await this.issueTokens({
        sub: user.id,
        tenantId: user.tenantId,
        email: user.email,
        role: user.role,
      }),
    };
  }

  async me(user: RequestUser) {
    const record = await this.prisma.user.findFirst({
      where: {
        id: user.id,
        tenantId: user.tenantId,
        isActive: true,
        deletedAt: null,
      },
      include: { tenant: true },
    });
    if (!record) {
      throw new UnauthorizedException("Current user is no longer active.");
    }

    return {
      user: this.toPublicUser(record),
      tenant: record.tenant,
    };
  }

  private async issueTokens(payload: Omit<TokenPayload, "typ">) {
    const issuer = this.config.get<string>("JWT_ISSUER");
    const accessOptions: JwtSignOptions = {
      issuer,
      secret: this.config.getOrThrow<string>("JWT_ACCESS_SECRET"),
      expiresIn: (this.config.get<string>("JWT_ACCESS_TTL") ??
        "15m") as JwtSignOptions["expiresIn"],
    };
    const refreshOptions: JwtSignOptions = {
      issuer,
      secret: this.config.getOrThrow<string>("JWT_REFRESH_SECRET"),
      expiresIn: (this.config.get<string>("JWT_REFRESH_TTL") ??
        "30d") as JwtSignOptions["expiresIn"],
    };
    const [accessToken, refreshToken] = await Promise.all([
      this.jwt.signAsync({ ...payload, typ: "access" }, accessOptions),
      this.jwt.signAsync({ ...payload, typ: "refresh" }, refreshOptions),
    ]);

    return {
      accessToken,
      refreshToken,
      tokenType: "Bearer",
    };
  }

  private toPublicUser(user: {
    id: string;
    tenantId: string;
    firstName: string;
    lastName: string;
    email: string;
    phone: string | null;
    role: string;
    isActive: boolean;
  }) {
    return {
      id: user.id,
      tenantId: user.tenantId,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      phone: user.phone,
      role: user.role,
      isActive: user.isActive,
    };
  }
}
