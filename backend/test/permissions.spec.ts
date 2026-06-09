import { ForbiddenException, UnauthorizedException } from "@nestjs/common";
import { Reflector } from "@nestjs/core";

import { REQUIRED_PERMISSIONS } from "../src/common/decorators/require-permissions.decorator";
import { PermissionGuard } from "../src/common/guards/permission.guard";
import {
  permissionsForRole,
  roleHasPermission,
} from "../src/common/permissions/permissions";

describe("permissions", () => {
  it("allows admins to perform every permission", () => {
    expect(roleHasPermission("admin", "entity:users:delete")).toBe(true);
    expect(roleHasPermission("admin", "tenancy:write")).toBe(true);
  });

  it("grants technicians field-work permissions without tenant admin access", () => {
    expect(roleHasPermission("technician", "sync:push")).toBe(true);
    expect(roleHasPermission("technician", "entity:work_orders:write")).toBe(
      true,
    );
    expect(roleHasPermission("technician", "entity:report_templates:read")).toBe(
      true,
    );
    expect(
      roleHasPermission("technician", "entity:report_templates:write"),
    ).toBe(false);
    expect(roleHasPermission("technician", "entity:users:write")).toBe(false);
    expect(roleHasPermission("technician", "tenancy:write")).toBe(false);
  });

  it("keeps dispatcher access focused on planning and office flows", () => {
    expect(roleHasPermission("dispatcher", "disposition:write")).toBe(true);
    expect(roleHasPermission("dispatcher", "entity:materials:write")).toBe(
      true,
    );
    expect(roleHasPermission("dispatcher", "entity:report_templates:read")).toBe(
      true,
    );
    expect(roleHasPermission("dispatcher", "sync:push")).toBe(false);
    expect(roleHasPermission("dispatcher", "entity:users:delete")).toBe(false);
  });

  it("returns defensive copies of role permissions", () => {
    const permissions = permissionsForRole("technician");
    permissions.push("entity:users:write");

    expect(roleHasPermission("technician", "entity:users:write")).toBe(false);
  });
});

describe("PermissionGuard", () => {
  it("allows routes without required permissions", () => {
    const guard = new PermissionGuard(reflectorWith(undefined));

    expect(guard.canActivate(contextWithRole("technician"))).toBe(true);
  });

  it("allows users with all required permissions", () => {
    const guard = new PermissionGuard(
      reflectorWith(["sync:pull", "entity:work_orders:read"]),
    );

    expect(guard.canActivate(contextWithRole("technician"))).toBe(true);
  });

  it("rejects missing authenticated users on protected permission routes", () => {
    const guard = new PermissionGuard(reflectorWith(["sync:pull"]));

    expect(() => guard.canActivate(contextWithRole(undefined))).toThrow(
      UnauthorizedException,
    );
  });

  it("rejects authenticated users without the required permission", () => {
    const guard = new PermissionGuard(reflectorWith(["entity:users:write"]));

    expect(() => guard.canActivate(contextWithRole("technician"))).toThrow(
      ForbiddenException,
    );
  });
});

function reflectorWith(permissions: string[] | undefined) {
  return {
    getAllAndOverride: jest.fn((key: string) =>
      key === REQUIRED_PERMISSIONS ? permissions : undefined,
    ),
  } as unknown as Reflector;
}

function contextWithRole(role: string | undefined) {
  return {
    getHandler: jest.fn(),
    getClass: jest.fn(),
    switchToHttp: () => ({
      getRequest: () => ({
        user: role
          ? {
              id: "user-1",
              tenantId: "tenant-1",
              email: "user@example.invalid",
              role,
            }
          : undefined,
      }),
    }),
  } as never;
}
