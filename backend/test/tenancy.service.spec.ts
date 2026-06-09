import { BadRequestException, ForbiddenException } from "@nestjs/common";

import { AuthService } from "../src/auth/auth.service";
import { RequestUser } from "../src/common/types/request-user";
import { PrismaService } from "../src/prisma/prisma.service";
import { TenancyService } from "../src/tenancy/tenancy.service";

const admin: RequestUser = {
  id: "admin-1",
  tenantId: "tenant-1",
  email: "admin@example.invalid",
  role: "admin",
};

function prismaMock(overrides: Record<string, unknown> = {}) {
  return {
    $transaction: jest.fn(),
    tenant: {
      findFirst: jest.fn(),
      update: jest.fn(),
    },
    ...overrides,
  } as unknown as PrismaService;
}

function authMock(overrides: Record<string, unknown> = {}) {
  return {
    createSessionForUser: jest.fn().mockResolvedValue({
      user: { id: "admin-1" },
      tokens: {
        accessToken: "access-token",
        refreshToken: "refresh-token",
      },
    }),
    ...overrides,
  } as unknown as AuthService;
}

function tenant(overrides: Record<string, unknown> = {}) {
  return {
    id: "tenant-1",
    slug: "keller-kaminfeger",
    name: "Keller Kaminfeger",
    plan: "starter",
    status: "active",
    address: "Hauptstrasse 1",
    postalCode: "8000",
    city: "Zuerich",
    country: "CH",
    phone: "+41 44 000 00 00",
    email: "info@example.invalid",
    ...overrides,
  };
}

describe("TenancyService", () => {
  it("signs up a new tenant with an initial admin session", async () => {
    const createdTenant = tenant();
    const createdUser = {
      id: "admin-1",
      tenantId: "tenant-1",
      firstName: "Ada",
      lastName: "Admin",
      email: "ada@example.invalid",
      phone: null,
      role: "admin",
      isActive: true,
    };
    const tx = {
      tenant: {
        create: jest.fn().mockResolvedValue(createdTenant),
      },
      user: {
        create: jest.fn().mockResolvedValue(createdUser),
      },
    };
    const transaction = jest.fn(async (callback) => callback(tx));
    const auth = authMock();
    const service = new TenancyService(
      prismaMock({ $transaction: transaction }),
      auth,
    );

    const result = await service.signup({
      tenantName: "Keller Kaminfeger",
      address: "Hauptstrasse 1",
      postalCode: "8000",
      city: "Zuerich",
      phone: "+41 44 000 00 00",
      email: "info@example.invalid",
      adminFirstName: "Ada",
      adminLastName: "Admin",
      adminEmail: "ADA@example.invalid",
      adminPassword: "admin1234",
    });

    expect(tx.tenant.create).toHaveBeenCalledWith({
      data: expect.objectContaining({
        slug: "keller-kaminfeger",
        name: "Keller Kaminfeger",
        plan: "starter",
        status: "active",
      }),
    });
    expect(tx.user.create).toHaveBeenCalledWith({
      data: expect.objectContaining({
        tenantId: "tenant-1",
        email: "ada@example.invalid",
        role: "admin",
        isActive: true,
        passwordHash: expect.any(String),
      }),
    });
    expect(auth.createSessionForUser).toHaveBeenCalledWith(createdUser);
    expect(result).toMatchObject({
      tenant: { slug: "keller-kaminfeger", status: "active" },
      user: { id: "admin-1" },
      tokens: { accessToken: "access-token" },
    });
  });

  it("rejects signup passwords below the minimum length", async () => {
    const service = new TenancyService(prismaMock(), authMock());

    await expect(
      service.signup({
        tenantName: "Keller",
        address: "Hauptstrasse 1",
        postalCode: "8000",
        city: "Zuerich",
        phone: "+41 44 000 00 00",
        email: "info@example.invalid",
        adminFirstName: "Ada",
        adminLastName: "Admin",
        adminEmail: "ada@example.invalid",
        adminPassword: "short",
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it("updates current tenant profile only for tenant admins", async () => {
    const update = jest.fn().mockResolvedValue(
      tenant({
        name: "Keller Kaminfeger AG",
        email: "office@example.invalid",
      }),
    );
    const service = new TenancyService(
      prismaMock({ tenant: { update } }),
      authMock(),
    );

    const result = await service.updateCurrent("tenant-1", admin, {
      name: "Keller Kaminfeger AG",
      email: "Office@Example.Invalid",
    });

    expect(update).toHaveBeenCalledWith({
      where: { id: "tenant-1" },
      data: {
        name: "Keller Kaminfeger AG",
        email: "office@example.invalid",
      },
    });
    expect(result).toMatchObject({
      name: "Keller Kaminfeger AG",
      email: "office@example.invalid",
    });
  });

  it("rejects non-admin tenant profile updates", async () => {
    const service = new TenancyService(prismaMock(), authMock());

    await expect(
      service.updateCurrent(
        "tenant-1",
        { ...admin, role: "dispatcher" },
        { name: "New Name" },
      ),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });
});
