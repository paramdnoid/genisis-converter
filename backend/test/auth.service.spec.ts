import { UnauthorizedException } from "@nestjs/common";
import { JwtService } from "@nestjs/jwt";
import { hash } from "bcryptjs";

import { AuthService } from "../src/auth/auth.service";
import { PrismaService } from "../src/prisma/prisma.service";

function config() {
  return {
    get: jest.fn((key: string) => {
      const values: Record<string, string> = {
        JWT_ISSUER: "test-issuer",
        JWT_ACCESS_SECRET: "access-secret",
        JWT_REFRESH_SECRET: "refresh-secret",
        JWT_ACCESS_TTL: "15m",
        JWT_REFRESH_TTL: "30d",
      };
      return values[key];
    }),
    getOrThrow: jest.fn((key: string) => {
      const values: Record<string, string> = {
        JWT_ACCESS_SECRET: "access-secret",
        JWT_REFRESH_SECRET: "refresh-secret",
      };
      return values[key];
    }),
  };
}

describe("AuthService", () => {
  it("logs in active users and issues access and refresh tokens", async () => {
    const passwordHash = await hash("secret-password", 4);
    const prisma = {
      user: {
        findFirst: jest.fn().mockResolvedValue({
          id: "user-1",
          tenantId: "tenant-1",
          firstName: "Ada",
          lastName: "Admin",
          email: "ada@example.invalid",
          phone: null,
          role: "admin",
          passwordHash,
          isActive: true,
          tenant: { id: "tenant-1", name: "Tenant" },
        }),
      },
    } as unknown as PrismaService;

    const service = new AuthService(
      prisma,
      new JwtService(),
      config() as never,
    );
    const result = await service.login({
      email: "ADA@example.invalid",
      password: "secret-password",
    });

    expect(result.user).toMatchObject({
      id: "user-1",
      tenantId: "tenant-1",
      email: "ada@example.invalid",
      role: "admin",
    });
    expect(result.tokens.accessToken).toEqual(expect.any(String));
    expect(result.tokens.refreshToken).toEqual(expect.any(String));
  });

  it("rejects invalid credentials without issuing tokens", async () => {
    const prisma = {
      user: {
        findFirst: jest.fn().mockResolvedValue(null),
      },
    } as unknown as PrismaService;

    const service = new AuthService(
      prisma,
      new JwtService(),
      config() as never,
    );

    await expect(
      service.login({ email: "missing@example.invalid", password: "wrong" }),
    ).rejects.toBeInstanceOf(UnauthorizedException);
  });

  it("refreshes a valid refresh token for an active user", async () => {
    const jwt = new JwtService();
    const refreshToken = await jwt.signAsync(
      {
        sub: "user-1",
        tenantId: "tenant-1",
        email: "user@example.invalid",
        role: "technician",
        typ: "refresh",
      },
      {
        issuer: "test-issuer",
        secret: "refresh-secret",
        expiresIn: "1h",
      },
    );
    const prisma = {
      user: {
        findFirst: jest.fn().mockResolvedValue({
          id: "user-1",
          tenantId: "tenant-1",
          email: "user@example.invalid",
          role: "technician",
          isActive: true,
        }),
      },
    } as unknown as PrismaService;

    const service = new AuthService(prisma, jwt, config() as never);
    const result = await service.refresh({ refreshToken });

    expect(result.tokens.accessToken).toEqual(expect.any(String));
    expect(result.tokens.refreshToken).toEqual(expect.any(String));
  });
});
