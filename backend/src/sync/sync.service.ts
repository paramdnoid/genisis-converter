import { BadRequestException, Injectable } from "@nestjs/common";
import { Prisma } from "@prisma/client";
import { randomUUID } from "node:crypto";

import { EntityCrudService } from "../entities/entity-crud.service";
import {
  ENTITY_DEFINITIONS,
  EntityKey,
  SYNC_ENTITY_KEYS,
  normalizeEntityKey,
} from "../entities/entity-map";
import { PrismaService } from "../prisma/prisma.service";

interface SyncPushEntry {
  outboxId?: string;
  entityType?: string;
  entityId?: string;
  operation?: string;
  baseVersion?: number;
  payload?: Record<string, unknown>;
}

const BACKEND_ONLY_SYNC_FIELDS = new Set([
  "passwordHash",
  "sourceSystem",
  "sourceFile",
  "sourceTable",
  "sourceKey",
]);
const SYNC_PULL_LIMIT = "100000";

@Injectable()
export class SyncService {
  constructor(
    private readonly crud: EntityCrudService,
    private readonly prisma: PrismaService,
  ) {}

  async pull(tenantId: string, query: Record<string, string>) {
    const entityType = query.entityType
      ? normalizeEntityKey(query.entityType)
      : undefined;
    const cursor = query.cursor ?? query.since;
    const serverTime = new Date().toISOString();

    if (query.entityType && !entityType) {
      throw new BadRequestException(
        `Unsupported sync entityType: ${query.entityType}`,
      );
    }

    if (entityType) {
      const changes = await this.pullEntityChanges(
        tenantId,
        entityType,
        cursor,
      );
      return {
        nextCursor: serverTime,
        cursor: serverTime,
        serverTime,
        changes,
      };
    }

    const changes: Record<string, unknown[]> = {};
    for (const key of SYNC_ENTITY_KEYS) {
      const definition = ENTITY_DEFINITIONS[key];
      const records = await this.crud.list(key, tenantId, {
        includeDeleted: "true",
        since: cursor,
        limit: SYNC_PULL_LIMIT,
      });
      changes[definition.collection] = records.map((record) =>
        this.toSyncRecord(record, key),
      );
    }

    return {
      cursor: serverTime,
      serverTime,
      changes,
    };
  }

  async push(tenantId: string, userId: string, body: Record<string, unknown>) {
    const requestTenant = body.tenantId?.toString();
    if (requestTenant && requestTenant !== tenantId) {
      throw new BadRequestException(
        "Push tenantId does not match authenticated tenant.",
      );
    }

    const entries = Array.isArray(body.entries)
      ? (body.entries as SyncPushEntry[])
      : [];
    const accepted: Record<string, unknown>[] = [];
    const rejected: Record<string, unknown>[] = [];

    for (const entry of entries) {
      const result = await this.processPushEntry(tenantId, userId, entry);
      if (result.accepted) {
        accepted.push(result.response);
      } else {
        rejected.push(result.response);
      }
    }

    return {
      accepted,
      rejected,
    };
  }

  private async pullEntityChanges(
    tenantId: string,
    entity: EntityKey,
    cursor?: string,
  ) {
    const definition = ENTITY_DEFINITIONS[entity];
    const records = await this.crud.list(entity, tenantId, {
      includeDeleted: "true",
      since: cursor,
      limit: SYNC_PULL_LIMIT,
    });

    return records.map((record) => ({
      entityType: definition.singular,
      operation: this.isDeleted(record) ? "delete" : "upsert",
      data: this.toSyncRecord(record, entity),
    }));
  }

  private toSyncRecord(record: unknown, entity?: EntityKey) {
    if (typeof record !== "object" || record === null) {
      return record;
    }

    const data = { ...(record as Record<string, unknown>) };
    if (entity === "legacy_import_records") {
      data.payloadJson = JSON.stringify(data.payload ?? null);
      delete data.payload;
      return data;
    }

    for (const field of BACKEND_ONLY_SYNC_FIELDS) {
      delete data[field];
    }
    return data;
  }

  private async processPushEntry(
    tenantId: string,
    userId: string,
    entry: SyncPushEntry,
  ) {
    const outboxId = entry.outboxId?.toString();
    const entityType = entry.entityType
      ? normalizeEntityKey(entry.entityType)
      : undefined;
    const entityId = entry.entityId?.toString();
    const operation = entry.operation?.toString() ?? "update";
    const payload = entry.payload ?? {};

    if (!outboxId) {
      return this.rejectEntry(tenantId, userId, entry, "invalid_entry");
    }

    const previous = await this.prisma.syncOutboxEntry.findUnique({
      where: {
        tenantId_outboxId: {
          tenantId,
          outboxId,
        },
      },
    });
    if (previous) {
      return this.replayPrevious(previous);
    }

    if (!entityType || !entityId) {
      return this.rejectEntry(tenantId, userId, entry, "invalid_entry");
    }

    if (!this.isSupportedOperation(operation)) {
      return this.rejectEntry(tenantId, userId, entry, "unsupported_operation");
    }

    const existing = await this.crud.findTenantRecord(
      entityType,
      tenantId,
      entityId,
      true,
    );
    const baseVersion = this.numberValue(entry.baseVersion);
    if (
      existing &&
      baseVersion !== undefined &&
      Number(existing.version ?? 1) > baseVersion &&
      operation !== "create"
    ) {
      return this.rejectEntry(tenantId, userId, entry, "conflict", existing);
    }

    const record = await this.crud.applySyncMutation({
      entity: entityType,
      tenantId,
      entityId,
      operation,
      payload,
    });
    const serverVersion = Number(record.version ?? 1);

    await this.prisma.syncOutboxEntry.create({
      data: {
        tenantId,
        outboxId,
        entityType: ENTITY_DEFINITIONS[entityType].singular,
        entityId,
        operation,
        status: "accepted",
        serverVersion,
      },
    });
    await this.audit(
      tenantId,
      userId,
      `sync_${operation}`,
      entityType,
      entityId,
      {
        outboxId,
        serverVersion,
      },
    );

    return {
      accepted: true,
      response: {
        outboxId,
        entityType: ENTITY_DEFINITIONS[entityType].singular,
        entityId,
        serverVersion,
      },
    };
  }

  private async rejectEntry(
    tenantId: string,
    userId: string,
    entry: SyncPushEntry,
    reason: string,
    serverRecord?: Record<string, unknown> | null,
  ) {
    const outboxId = entry.outboxId?.toString() ?? `invalid-${randomUUID()}`;
    const entityType = entry.entityType?.toString() ?? "unknown";
    const entityId = entry.entityId?.toString() ?? "unknown";

    await this.prisma.syncOutboxEntry.create({
      data: {
        tenantId,
        outboxId,
        entityType,
        entityId,
        operation: entry.operation?.toString() ?? "unknown",
        status: "rejected",
        reason,
      },
    });
    await this.audit(
      tenantId,
      userId,
      "sync_rejected",
      normalizeEntityKey(entityType),
      entityId,
      {
        outboxId,
        reason,
      },
    );

    return {
      accepted: false,
      response: {
        outboxId,
        entityType,
        entityId,
        reason,
        serverRecord: serverRecord ?? undefined,
      },
    };
  }

  private replayPrevious(previous: {
    outboxId: string;
    entityType: string;
    entityId: string;
    status: string;
    reason: string | null;
    serverVersion: number | null;
  }) {
    if (previous.status === "accepted") {
      return {
        accepted: true,
        response: {
          outboxId: previous.outboxId,
          entityType: previous.entityType,
          entityId: previous.entityId,
          serverVersion: previous.serverVersion,
        },
      };
    }

    return {
      accepted: false,
      response: {
        outboxId: previous.outboxId,
        entityType: previous.entityType,
        entityId: previous.entityId,
        reason: previous.reason ?? "rejected",
      },
    };
  }

  private isSupportedOperation(operation: string) {
    return ["create", "update", "delete", "upload_file"].includes(operation);
  }

  private isDeleted(record: unknown) {
    return (
      typeof record === "object" &&
      record !== null &&
      "deletedAt" in record &&
      (record as { deletedAt?: unknown }).deletedAt !== null
    );
  }

  private numberValue(value: unknown) {
    if (value === undefined || value === null) {
      return undefined;
    }
    const parsed = Number(value);
    return Number.isFinite(parsed) ? parsed : undefined;
  }

  private async audit(
    tenantId: string,
    userId: string,
    action: string,
    entity: EntityKey | undefined,
    entityId: string,
    metadata: Record<string, unknown>,
  ) {
    await this.prisma.auditLog.create({
      data: {
        tenantId,
        userId,
        action,
        entityType: entity ? ENTITY_DEFINITIONS[entity].singular : "unknown",
        entityId,
        metadata: metadata as Prisma.InputJsonObject,
      },
    });
  }
}
