# Sync

Synchronization must be idempotent, retryable, and non-blocking for the UI.

## Principles

- Write locally first.
- Create outbox entries for local mutations.
- Pull server changes by cursor.
- Push pending outbox entries.
- Keep failed entries visible and retryable.
- Upload files separately from JSON entity data.
- Preserve local data during conflicts.

The mobile implementation now pulls cursor pages for the local sync entity
types, applies remote upserts/deletes directly to Drift, advances the local
cursor only after a successful transaction, and marks local unsynced rows as
`conflict` instead of overwriting them with server data.

The backend implementation exposes:

- `GET /sync/pull` for whole-tenant or entity-specific cursor pulls.
- `POST /sync/push` for mobile outbox entries.
- Idempotency via the `sync_outbox_entries` table and unique `(tenant_id, outbox_id)`.
- Conflict detection via `baseVersion` compared with the current server `version`.
- Soft deletes by setting `deleted_at`.
- Audit logging for accepted/rejected sync events.
- Separate file upload lifecycle through `/files/upload/init`, `PUT /files/upload/:id`, and `/files/upload/complete`.
