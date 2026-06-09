import { BadRequestException } from "@nestjs/common";

import { RequestUser } from "../src/common/types/request-user";
import { FirebasePushGateway } from "../src/push/push.gateway";
import { PushService } from "../src/push/push.service";

const user: RequestUser = {
  id: "technician-1",
  tenantId: "tenant-1",
  email: "tech@example.invalid",
  role: "technician",
};

function workOrder(overrides: Record<string, unknown> = {}) {
  return {
    id: "work-order-1",
    tenantId: "tenant-1",
    assignedUserId: "technician-1",
    orderNumber: "WO-2026-0100",
    title: "Neue Kontrolle",
    scheduledStart: new Date("2026-06-09T08:00:00.000Z"),
    customer: { displayName: "Familie Keller" },
    object: { name: "Einfamilienhaus" },
    ...overrides,
  };
}

function prismaMock(overrides: Record<string, unknown> = {}) {
  return {
    pushDeviceToken: {
      upsert: jest.fn(),
      updateMany: jest.fn().mockResolvedValue({ count: 0 }),
      findMany: jest.fn().mockResolvedValue([]),
    },
    workOrder: {
      findFirst: jest.fn(),
    },
    auditLog: {
      create: jest.fn().mockResolvedValue({}),
    },
    ...overrides,
  };
}

describe("PushService", () => {
  it("registers a device token for the authenticated user", async () => {
    const upsert = jest.fn().mockResolvedValue({
      id: "push-token-1",
      tenantId: "tenant-1",
      userId: "technician-1",
      platform: "android",
      deviceId: "device-1",
      appVersion: "1.0.0+1",
      revokedAt: null,
    });
    const prisma = prismaMock({
      pushDeviceToken: {
        upsert,
        updateMany: jest.fn(),
        findMany: jest.fn(),
      },
    });
    const service = new PushService(
      prisma as never,
      { send: jest.fn() } as unknown as FirebasePushGateway,
    );

    const result = await service.registerDeviceToken("tenant-1", user, {
      token: "fcm-token",
      platform: "Android",
      deviceId: "device-1",
      appVersion: "1.0.0+1",
    });

    expect(upsert).toHaveBeenCalledWith({
      where: {
        tenantId_token: {
          tenantId: "tenant-1",
          token: "fcm-token",
        },
      },
      update: expect.objectContaining({
        userId: "technician-1",
        platform: "android",
        revokedAt: null,
      }),
      create: expect.objectContaining({
        tenantId: "tenant-1",
        userId: "technician-1",
        token: "fcm-token",
        platform: "android",
      }),
      select: expect.any(Object),
    });
    expect(result).toMatchObject({ id: "push-token-1" });
  });

  it("rejects unsupported push platforms", async () => {
    const service = new PushService(
      prismaMock() as never,
      { send: jest.fn() } as unknown as FirebasePushGateway,
    );

    await expect(
      service.registerDeviceToken("tenant-1", user, {
        token: "fcm-token",
        platform: "desktop",
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it("sends new work order notifications and revokes invalid tokens", async () => {
    const findMany = jest
      .fn()
      .mockResolvedValue([{ token: "valid-token" }, { token: "stale-token" }]);
    const updateMany = jest.fn().mockResolvedValue({ count: 1 });
    const send = jest.fn().mockResolvedValue({
      successCount: 1,
      failureCount: 1,
      invalidTokens: ["stale-token"],
      disabled: false,
    });
    const prisma = prismaMock({
      pushDeviceToken: {
        upsert: jest.fn(),
        updateMany,
        findMany,
      },
      workOrder: {
        findFirst: jest.fn().mockResolvedValue(workOrder()),
      },
      auditLog: {
        create: jest.fn().mockResolvedValue({}),
      },
    });
    const service = new PushService(
      prisma as never,
      { send } as unknown as FirebasePushGateway,
    );

    const result = await service.notifyNewWorkOrder("tenant-1", "work-order-1");

    expect(send).toHaveBeenCalledWith({
      tokens: ["valid-token", "stale-token"],
      title: "Neuer Auftrag WO-2026-0100",
      body: "Neue Kontrolle · Familie Keller · 2026-06-09T08:00:00.000Z",
      data: expect.objectContaining({
        type: "new_work_order",
        workOrderId: "work-order-1",
        orderNumber: "WO-2026-0100",
      }),
    });
    expect(updateMany).toHaveBeenCalledWith({
      where: {
        tenantId: "tenant-1",
        token: { in: ["stale-token"] },
        revokedAt: null,
      },
      data: { revokedAt: expect.any(Date) },
    });
    expect(result).toMatchObject({
      targetUserId: "technician-1",
      tokenCount: 2,
      successCount: 1,
      failureCount: 1,
      disabled: false,
    });
  });

  it("does not call the gateway for unchanged assignments", async () => {
    const send = jest.fn();
    const prisma = prismaMock({
      workOrder: {
        findFirst: jest.fn().mockResolvedValue(workOrder()),
      },
    });
    const service = new PushService(
      prisma as never,
      { send } as unknown as FirebasePushGateway,
    );

    const result = await service.notifyNewWorkOrder(
      "tenant-1",
      "work-order-1",
      { previousAssignedUserId: "technician-1" },
    );

    expect(send).not.toHaveBeenCalled();
    expect(result).toMatchObject({ reason: "assignment_unchanged" });
  });
});
