import { Injectable, NotFoundException } from "@nestjs/common";

import { PrismaService } from "../prisma/prisma.service";
import { ENTITY_DEFINITIONS, EntityDefinition, EntityKey } from "./entity-map";

type PrismaDelegate = {
  findMany(args?: Record<string, unknown>): Promise<unknown[]>;
  findFirst(
    args?: Record<string, unknown>,
  ): Promise<Record<string, unknown> | null>;
  create(args: Record<string, unknown>): Promise<Record<string, unknown>>;
  update(args: Record<string, unknown>): Promise<Record<string, unknown>>;
  upsert?(args: Record<string, unknown>): Promise<Record<string, unknown>>;
};

interface ListQuery {
  includeDeleted?: string;
  since?: string;
  cursor?: string;
  limit?: string;
}

const RESERVED_FIELDS = new Set([
  "tenantId",
  "tenant_id",
  "createdAt",
  "created_at",
  "updatedAt",
  "updated_at",
  "deletedAt",
  "deleted_at",
  "version",
  "syncStatus",
  "sync_status",
  "lastSyncedAt",
  "last_synced_at",
]);

@Injectable()
export class EntityCrudService {
  constructor(private readonly prisma: PrismaService) {}

  async list(entity: EntityKey, tenantId: string, query: ListQuery = {}) {
    const definition = ENTITY_DEFINITIONS[entity];
    const where = this.tenantWhere(
      definition,
      tenantId,
      query.includeDeleted === "true",
    );
    const since = query.since ?? query.cursor;
    if (since) {
      where.updatedAt = { gt: new Date(since) };
    }

    return this.delegate(definition).findMany({
      where,
      orderBy: { updatedAt: "asc" },
      take: this.limit(query.limit),
    });
  }

  async get(entity: EntityKey, tenantId: string, id: string) {
    const record = await this.findTenantRecord(entity, tenantId, id, true);
    if (!record) {
      throw new NotFoundException(`${entity} record not found.`);
    }
    return record;
  }

  async create(
    entity: EntityKey,
    tenantId: string,
    body: Record<string, unknown>,
  ) {
    const definition = ENTITY_DEFINITIONS[entity];
    const data = {
      ...this.cleanWritePayload(body, { allowId: true }),
      ...this.tenantData(definition, tenantId),
      syncStatus: body.syncStatus?.toString() ?? "synced",
      lastSyncedAt: new Date(),
    };

    return this.delegate(definition).create({ data });
  }

  async update(
    entity: EntityKey,
    tenantId: string,
    id: string,
    body: Record<string, unknown>,
  ) {
    const definition = ENTITY_DEFINITIONS[entity];
    const existing = await this.findTenantRecord(entity, tenantId, id, true);
    if (!existing) {
      throw new NotFoundException(`${entity} record not found.`);
    }

    return this.delegate(definition).update({
      where: { id },
      data: {
        ...this.cleanWritePayload(body, { allowId: false }),
        version: Number(existing.version ?? 1) + 1,
        syncStatus: "synced",
        lastSyncedAt: new Date(),
      },
    });
  }

  async softDelete(entity: EntityKey, tenantId: string, id: string) {
    const definition = ENTITY_DEFINITIONS[entity];
    const existing = await this.findTenantRecord(entity, tenantId, id, true);
    if (!existing) {
      throw new NotFoundException(`${entity} record not found.`);
    }

    return this.delegate(definition).update({
      where: { id },
      data: {
        deletedAt: new Date(),
        version: Number(existing.version ?? 1) + 1,
        syncStatus: "synced",
        lastSyncedAt: new Date(),
      },
    });
  }

  async findTenantRecord(
    entity: EntityKey,
    tenantId: string,
    id: string,
    includeDeleted = false,
  ): Promise<Record<string, unknown> | null> {
    const definition = ENTITY_DEFINITIONS[entity];
    const where = this.tenantWhere(definition, tenantId, includeDeleted);
    where.id = id;

    return this.delegate(definition).findFirst({ where });
  }

  async applySyncMutation(args: {
    entity: EntityKey;
    tenantId: string;
    entityId: string;
    operation: string;
    payload: Record<string, unknown>;
  }) {
    const operation = args.operation.trim().toLowerCase();
    if (operation === "delete") {
      return this.softDelete(args.entity, args.tenantId, args.entityId);
    }

    const existing = await this.findTenantRecord(
      args.entity,
      args.tenantId,
      args.entityId,
      true,
    );
    if (existing) {
      return this.update(
        args.entity,
        args.tenantId,
        args.entityId,
        args.payload,
      );
    }

    return this.create(args.entity, args.tenantId, {
      ...args.payload,
      id: args.entityId,
    });
  }

  delegateFor(entity: EntityKey): PrismaDelegate {
    return this.delegate(ENTITY_DEFINITIONS[entity]);
  }

  tenantWhereFor(entity: EntityKey, tenantId: string, includeDeleted = true) {
    return this.tenantWhere(
      ENTITY_DEFINITIONS[entity],
      tenantId,
      includeDeleted,
    );
  }

  private delegate(definition: EntityDefinition): PrismaDelegate {
    return (this.prisma as unknown as Record<string, PrismaDelegate>)[
      definition.delegate
    ];
  }

  private tenantWhere(
    definition: EntityDefinition,
    tenantId: string,
    includeDeleted: boolean,
  ) {
    const where: Record<string, unknown> =
      definition.scope === "tenantRecord" ? { id: tenantId } : { tenantId };

    if (!includeDeleted) {
      where.deletedAt = null;
    }
    return where;
  }

  private tenantData(definition: EntityDefinition, tenantId: string) {
    return definition.scope === "tenantRecord"
      ? { id: tenantId }
      : { tenantId };
  }

  private cleanWritePayload(
    payload: Record<string, unknown>,
    options: { allowId: boolean },
  ): Record<string, unknown> {
    const data: Record<string, unknown> = {};
    for (const [key, value] of Object.entries(payload ?? {})) {
      if ((!options.allowId && key === "id") || RESERVED_FIELDS.has(key)) {
        continue;
      }
      data[key] = value;
    }
    return data;
  }

  private limit(value?: string) {
    const parsed = Number(value ?? 500);
    if (!Number.isFinite(parsed)) {
      return 500;
    }
    return Math.max(1, Math.min(1000, parsed));
  }
}
