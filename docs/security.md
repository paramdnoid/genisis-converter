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
- Login is tenant-aware: when an email exists in multiple active tenants,
  clients must send `tenantSlug` or `tenantId`, preventing accidental cross-
  tenant sessions.
- `x-tenant-id` is optional, but if present it must match the JWT tenant.
- CRUD, sync, file, and report operations scope queries by authenticated tenant.
- Tenant signup creates the tenant and initial admin atomically; tenant profile
  updates require the tenant admin role.
- A global permission guard enforces route-level permissions after JWT auth.
  `admin` has full access; `dispatcher` is limited to planning/office flows;
  `technician` is limited to field-work sync, upload, report, and assigned
  operational data permissions.
- Report templates are tenant-scoped. Dispatchers and technicians may read
  templates for PDF generation, while template writes remain admin-only through
  the RBAC matrix.
- Deletes are soft deletes, preserving auditability and sync safety.
- Sync push rejects stale `baseVersion` writes as conflicts.
- File upload completion and sync push decisions are written to `audit_logs`.
