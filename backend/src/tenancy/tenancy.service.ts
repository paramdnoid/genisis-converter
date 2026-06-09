import {
  BadRequestException,
  ConflictException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from "@nestjs/common";
import { Prisma } from "@prisma/client";
import { hash } from "bcryptjs";

import { AuthService } from "../auth/auth.service";
import { RequestUser } from "../common/types/request-user";
import { PrismaService } from "../prisma/prisma.service";

export interface TenantSignupRequest {
  tenantName?: string;
  tenantSlug?: string;
  address?: string;
  postalCode?: string;
  city?: string;
  country?: string;
  phone?: string;
  email?: string;
  adminFirstName?: string;
  adminLastName?: string;
  adminEmail?: string;
  adminPhone?: string;
  adminPassword?: string;
}

export interface UpdateTenantRequest {
  name?: string;
  address?: string;
  postalCode?: string;
  city?: string;
  country?: string;
  phone?: string;
  email?: string;
}

@Injectable()
export class TenancyService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly auth: AuthService,
  ) {}

  async signup(body: TenantSignupRequest) {
    const tenantName = requiredText(body.tenantName, "tenantName");
    const slug = normalizeSlug(body.tenantSlug ?? tenantName);
    const adminEmail = requiredText(body.adminEmail, "adminEmail")
      .trim()
      .toLowerCase();
    const adminPassword = requiredText(body.adminPassword, "adminPassword");
    if (adminPassword.length < 8) {
      throw new BadRequestException("adminPassword must be at least 8 chars.");
    }

    try {
      const created = await this.prisma.$transaction(async (tx) => {
        const tenant = await tx.tenant.create({
          data: {
            slug,
            name: tenantName,
            plan: "starter",
            status: "active",
            address: requiredText(body.address, "address"),
            postalCode: requiredText(body.postalCode, "postalCode"),
            city: requiredText(body.city, "city"),
            country: optionalText(body.country) ?? "CH",
            phone: requiredText(body.phone, "phone"),
            email: requiredText(body.email, "email").trim().toLowerCase(),
          },
        });
        const user = await tx.user.create({
          data: {
            tenantId: tenant.id,
            firstName: requiredText(body.adminFirstName, "adminFirstName"),
            lastName: requiredText(body.adminLastName, "adminLastName"),
            email: adminEmail,
            phone: optionalText(body.adminPhone),
            role: "admin",
            passwordHash: await hash(adminPassword, 12),
            isActive: true,
          },
        });
        return { tenant, user };
      });

      return {
        tenant: toPublicTenant(created.tenant),
        ...(await this.auth.createSessionForUser(created.user)),
      };
    } catch (error) {
      if (isUniqueConstraintError(error)) {
        throw new ConflictException(
          "Tenant slug or admin email already exists.",
        );
      }
      throw error;
    }
  }

  async current(tenantId: string) {
    const tenant = await this.prisma.tenant.findFirst({
      where: { id: tenantId, deletedAt: null },
    });
    if (!tenant) {
      throw new NotFoundException("Tenant not found.");
    }
    return toPublicTenant(tenant);
  }

  async updateCurrent(
    tenantId: string,
    user: RequestUser,
    body: UpdateTenantRequest,
  ) {
    this.assertTenantAdmin(user);
    const data = cleanTenantUpdate(body);
    if (Object.keys(data).length === 0) {
      throw new BadRequestException("No tenant fields supplied.");
    }

    const tenant = await this.prisma.tenant.update({
      where: { id: tenantId },
      data,
    });
    return toPublicTenant(tenant);
  }

  private assertTenantAdmin(user: RequestUser) {
    if (user.role !== "admin") {
      throw new ForbiddenException(
        "Tenant administration requires admin role.",
      );
    }
  }
}

function requiredText(value: unknown, field: string) {
  const trimmed = value?.toString().trim() ?? "";
  if (!trimmed) {
    throw new BadRequestException(`${field} is required.`);
  }
  return trimmed;
}

function optionalText(value: unknown) {
  const trimmed = value?.toString().trim() ?? "";
  return trimmed || null;
}

function normalizeSlug(value: unknown) {
  const slug = value
    ?.toString()
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
  if (!slug || slug.length < 3) {
    throw new BadRequestException("tenantSlug must contain at least 3 chars.");
  }
  return slug;
}

function cleanTenantUpdate(body: UpdateTenantRequest) {
  const data: Prisma.TenantUpdateInput = {};
  if (body.name !== undefined) {
    data.name = requiredText(body.name, "name");
  }
  if (body.address !== undefined) {
    data.address = requiredText(body.address, "address");
  }
  if (body.postalCode !== undefined) {
    data.postalCode = requiredText(body.postalCode, "postalCode");
  }
  if (body.city !== undefined) {
    data.city = requiredText(body.city, "city");
  }
  if (body.country !== undefined) {
    data.country = requiredText(body.country, "country");
  }
  if (body.phone !== undefined) {
    data.phone = requiredText(body.phone, "phone");
  }
  if (body.email !== undefined) {
    data.email = requiredText(body.email, "email").trim().toLowerCase();
  }
  return data;
}

function toPublicTenant(tenant: {
  id: string;
  slug: string;
  name: string;
  plan: string;
  status: string;
  address: string;
  postalCode: string;
  city: string;
  country: string;
  phone: string;
  email: string;
}) {
  return {
    id: tenant.id,
    slug: tenant.slug,
    name: tenant.name,
    plan: tenant.plan,
    status: tenant.status,
    address: tenant.address,
    postalCode: tenant.postalCode,
    city: tenant.city,
    country: tenant.country,
    phone: tenant.phone,
    email: tenant.email,
  };
}

function isUniqueConstraintError(error: unknown) {
  return (
    error instanceof Prisma.PrismaClientKnownRequestError &&
    error.code === "P2002"
  );
}
