import { EntityCrudService } from "../src/entities/entity-crud.service";
import { PrismaService } from "../src/prisma/prisma.service";
import { SyncService } from "../src/sync/sync.service";

function prismaMock(overrides: Record<string, unknown> = {}) {
  return {
    syncOutboxEntry: {
      findUnique: jest.fn(),
      create: jest.fn().mockResolvedValue({}),
    },
    auditLog: {
      create: jest.fn().mockResolvedValue({}),
    },
    ...overrides,
  } as unknown as PrismaService;
}

describe("SyncService", () => {
  it("returns mobile-compatible flat changes for entity-specific pulls", async () => {
    const crud = {
      list: jest.fn().mockResolvedValue([
        {
          id: "customer-1",
          tenantId: "tenant-1",
          displayName: "Kunde",
          version: 2,
          deletedAt: null,
        },
      ]),
    } as unknown as EntityCrudService;
    const service = new SyncService(crud, prismaMock());

    const result = await service.pull("tenant-1", {
      entityType: "customers",
      cursor: "2026-01-01T00:00:00.000Z",
    });

    expect(result).toMatchObject({
      changes: [
        {
          entityType: "customer",
          operation: "upsert",
          data: {
            id: "customer-1",
            tenantId: "tenant-1",
          },
        },
      ],
    });
    expect(result).toHaveProperty("nextCursor");
    expect(crud.list).toHaveBeenCalledWith("customers", "tenant-1", {
      includeDeleted: "true",
      since: "2026-01-01T00:00:00.000Z",
    });
  });

  it("rejects stale push entries as conflicts and stores idempotency state", async () => {
    const crud = {
      findTenantRecord: jest.fn().mockResolvedValue({
        id: "work-order-1",
        tenantId: "tenant-1",
        version: 5,
      }),
    } as unknown as EntityCrudService;
    const prisma = prismaMock();
    const service = new SyncService(crud, prisma);

    const result = await service.push("tenant-1", "user-1", {
      tenantId: "tenant-1",
      entries: [
        {
          outboxId: "outbox-1",
          entityType: "work_order",
          entityId: "work-order-1",
          operation: "update",
          baseVersion: 3,
          payload: { status: "completed" },
        },
      ],
    });

    expect(result.accepted).toEqual([]);
    expect(result.rejected).toHaveLength(1);
    expect(result.rejected[0]).toMatchObject({
      outboxId: "outbox-1",
      reason: "conflict",
      serverRecord: {
        version: 5,
      },
    });
    expect(prisma.syncOutboxEntry.create).toHaveBeenCalledWith({
      data: expect.objectContaining({
        outboxId: "outbox-1",
        status: "rejected",
        reason: "conflict",
      }),
    });
  });

  it("replays already accepted outbox entries without mutating entities again", async () => {
    const crud = {
      findTenantRecord: jest.fn(),
      applySyncMutation: jest.fn(),
    } as unknown as EntityCrudService;
    const prisma = prismaMock({
      syncOutboxEntry: {
        findUnique: jest.fn().mockResolvedValue({
          outboxId: "outbox-1",
          entityType: "customer",
          entityId: "customer-1",
          status: "accepted",
          reason: null,
          serverVersion: 4,
        }),
        create: jest.fn(),
      },
    });
    const service = new SyncService(crud, prisma);

    const result = await service.push("tenant-1", "user-1", {
      entries: [
        {
          outboxId: "outbox-1",
          entityType: "customer",
          entityId: "customer-1",
          operation: "update",
          baseVersion: 3,
          payload: { notes: "already synced" },
        },
      ],
    });

    expect(result.accepted).toEqual([
      {
        outboxId: "outbox-1",
        entityType: "customer",
        entityId: "customer-1",
        serverVersion: 4,
      },
    ]);
    expect(crud.applySyncMutation).not.toHaveBeenCalled();
  });
});
