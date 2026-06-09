import { ForbiddenException } from "@nestjs/common";

import { RequestUser } from "../src/common/types/request-user";
import { DispositionService } from "../src/disposition/disposition.service";
import { PrismaService } from "../src/prisma/prisma.service";

const dispatcher: RequestUser = {
  id: "dispatcher-1",
  tenantId: "tenant-1",
  email: "dispatcher@example.invalid",
  role: "dispatcher",
};

function prismaMock(overrides: Record<string, unknown> = {}) {
  return {
    workOrder: {
      findMany: jest.fn().mockResolvedValue([]),
      findFirst: jest.fn(),
      updateMany: jest.fn(),
    },
    user: {
      findMany: jest.fn().mockResolvedValue([]),
      findFirst: jest.fn(),
    },
    ...overrides,
  } as unknown as PrismaService;
}

function workOrder(overrides: Record<string, unknown> = {}) {
  return {
    id: "work-order-1",
    tenantId: "tenant-1",
    customerId: "customer-1",
    objectId: "object-1",
    assignedUserId: "technician-1",
    orderNumber: "WO-1",
    title: "Jahreskontrolle",
    description: null,
    type: "inspection",
    status: "scheduled",
    priority: "normal",
    scheduledStart: new Date("2026-06-08T08:00:00.000Z"),
    scheduledEnd: new Date("2026-06-08T09:00:00.000Z"),
    actualStart: null,
    actualEnd: null,
    customerSignatureFileId: null,
    reportFileId: null,
    completionNotes: null,
    createdAt: new Date("2026-06-01T00:00:00.000Z"),
    updatedAt: new Date("2026-06-01T00:00:00.000Z"),
    deletedAt: null,
    version: 1,
    syncStatus: "synced",
    lastSyncedAt: null,
    customer: {
      id: "customer-1",
      displayName: "Familie Keller",
    },
    object: {
      id: "object-1",
      name: "Einfamilienhaus",
      street: "Im Ried",
      houseNumber: "7",
      postalCode: "8610",
      city: "Uster",
    },
    ...overrides,
  };
}

describe("DispositionService", () => {
  it("builds a dispatcher snapshot with metrics, technicians and orders", async () => {
    const prisma = prismaMock({
      workOrder: {
        findMany: jest.fn().mockResolvedValue([
          workOrder({
            id: "work-order-1",
            status: "scheduled",
            scheduledEnd: new Date("2000-01-01T09:00:00.000Z"),
          }),
          workOrder({
            id: "work-order-2",
            assignedUserId: null,
            status: "completed",
            scheduledEnd: new Date("2099-01-01T09:00:00.000Z"),
          }),
        ]),
      },
      user: {
        findMany: jest.fn().mockResolvedValue([
          {
            id: "technician-1",
            firstName: "Mia",
            lastName: "Monteur",
            email: "mia@example.invalid",
            role: "technician",
            isActive: true,
          },
          {
            id: "dispatcher-1",
            firstName: "Dina",
            lastName: "Disposition",
            email: "dina@example.invalid",
            role: "dispatcher",
            isActive: true,
          },
        ]),
      },
    });
    const service = new DispositionService(prisma);

    const snapshot = await service.snapshot("tenant-1", dispatcher);

    expect(snapshot.metrics).toMatchObject({
      total: 2,
      open: 1,
      scheduled: 1,
      completed: 1,
      overdue: 1,
      unassigned: 1,
    });
    expect(snapshot.technicians).toEqual([
      {
        id: "technician-1",
        name: "Mia Monteur",
        email: "mia@example.invalid",
        role: "technician",
        isActive: true,
      },
    ]);
    expect(snapshot.workOrders[0]).toMatchObject({
      orderNumber: "WO-1",
      customerName: "Familie Keller",
      assignedUserName: "Mia Monteur",
      address: "Im Ried 7 8610 Uster",
      isOverdue: true,
    });
  });

  it("rejects technician access to dispatcher data", async () => {
    const service = new DispositionService(prismaMock());

    await expect(
      service.snapshot("tenant-1", {
        ...dispatcher,
        role: "technician",
      }),
    ).rejects.toBeInstanceOf(ForbiddenException);
  });

  it("updates assignable dispatch fields only for active technicians", async () => {
    const updateMany = jest.fn().mockResolvedValue({ count: 1 });
    const findFirstWorkOrder = jest.fn().mockResolvedValue(
      workOrder({
        assignedUserId: "technician-2",
        status: "in_progress",
        priority: "high",
      }),
    );
    const prisma = prismaMock({
      workOrder: {
        updateMany,
        findFirst: findFirstWorkOrder,
      },
      user: {
        findFirst: jest.fn().mockResolvedValue({
          id: "technician-2",
          tenantId: "tenant-1",
          role: "technician",
          isActive: true,
        }),
        findMany: jest.fn().mockResolvedValue([
          {
            id: "technician-2",
            firstName: "Lina",
            lastName: "Leiter",
            email: "lina@example.invalid",
            role: "technician",
            isActive: true,
          },
        ]),
      },
    });
    const service = new DispositionService(prisma);

    const updated = await service.updateWorkOrder(
      "tenant-1",
      dispatcher,
      "work-order-1",
      {
        assignedUserId: "technician-2",
        status: "in_progress",
        priority: "high",
        scheduledStart: "2026-06-08T10:00:00.000Z",
      },
    );

    expect(updateMany).toHaveBeenCalledWith({
      where: { id: "work-order-1", tenantId: "tenant-1", deletedAt: null },
      data: expect.objectContaining({
        assignedUserId: "technician-2",
        status: "in_progress",
        priority: "high",
        scheduledStart: new Date("2026-06-08T10:00:00.000Z"),
      }),
    });
    expect(updated).toMatchObject({
      id: "work-order-1",
      assignedUserId: "technician-2",
      assignedUserName: "Lina Leiter",
      status: "in_progress",
      priority: "high",
    });
  });
});
