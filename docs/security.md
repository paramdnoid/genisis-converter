# Security

## Baseline

- Do not commit secrets.
- Store tokens only in secure storage once authentication is implemented.
- Enforce HTTPS outside local development.
- Treat local customer, object, photo, signature, and report data as sensitive.
- Keep tenant separation as a backend invariant.

Database encryption is intentionally left as a later evaluation item because it affects performance, platform setup, and operational support.

## Backend Controls

- All non-public backend routes require JWT bearer authentication.
- JWT payloads carry `tenantId`, `role`, `email`, and user id.
- `x-tenant-id` is optional, but if present it must match the JWT tenant.
- CRUD, sync, file, and report operations scope queries by authenticated tenant.
- Deletes are soft deletes, preserving auditability and sync safety.
- Sync push rejects stale `baseVersion` writes as conflicts.
- File upload completion and sync push decisions are written to `audit_logs`.
