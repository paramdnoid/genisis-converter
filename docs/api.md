# API

The backend API is implemented in `backend/` with NestJS, Prisma, JWT auth, and PostgreSQL.

## Auth

- `POST /auth/login`
- `POST /auth/refresh`
- `POST /auth/logout`
- `GET /me`

`POST /auth/login` accepts `email`, `password`, and optional `tenantSlug` or
`tenantId`. The tenant selector is required when the same email exists in more
than one active tenant.

All routes except `/health`, `/auth/login`, `/auth/refresh`, and
`/tenancy/signup` require a bearer access token. The token contains `sub`,
`tenantId`, `email`, and `role`. The optional `x-tenant-id` header must match
the token tenant.

After authentication, route-level permissions are enforced by role. Admins have
full access. Dispatchers can use planning, report, material, and read-heavy
office flows. Technicians can sync, upload, register push tokens, generate
reports, and mutate field-work entities such as work orders, checklist answers,
measurements, defects, photos, time entries, material usage, and service lines.

## Tenancy

- `POST /tenancy/signup`
- `GET /tenancy/current`
- `PATCH /tenancy/current`

Signup creates a new active tenant with a unique `slug`, starter plan, and an
initial admin user in one transaction. Current-tenant updates are limited to
tenant admins and update profile fields only.

## Health

- `GET /health`

## Sync

- `GET /sync/pull?cursor=:cursor`
- `GET /sync/pull?entityType=:entityType&cursor=:cursor`
- `POST /sync/push`

Entity-specific pulls return the mobile-compatible shape:

```json
{
  "nextCursor": "2026-06-08T10:00:00.000Z",
  "cursor": "2026-06-08T10:00:00.000Z",
  "serverTime": "2026-06-08T10:00:00.000Z",
  "changes": [
    {
      "entityType": "customer",
      "operation": "upsert",
      "data": {
        "id": "uuid",
        "tenantId": "uuid",
        "createdAt": "2026-01-01T00:00:00.000Z",
        "updatedAt": "2026-01-01T00:00:00.000Z",
        "version": 2
      }
    }
  ]
}
```

Whole-tenant pulls return the roadmap collection shape:

```json
{
  "cursor": "2026-06-08T10:00:00.000Z",
  "serverTime": "2026-06-08T10:00:00.000Z",
  "changes": {
    "customers": [],
    "objects": [],
    "installations": [],
    "work_orders": [],
    "checklist_templates": [],
    "report_templates": [],
    "materials": []
  }
}
```

Push entries are idempotent by `outboxId`. If `baseVersion` is stale, the backend rejects the entry with `reason=conflict` and returns the current `serverRecord`.

## Files

- `POST /files/upload/init`
- `PUT /files/upload/:id`
- `POST /files/upload/complete`

The file flow creates upload metadata, marks the upload as transferred, then completes it with optional checksum metadata and an audit-log entry.

## Entity CRUD

Tenant-scoped REST CRUD routes are available for:

- `/tenants`
- `/users`
- `/customers`
- `/objects`
- `/installations`
- `/work-orders`
- `/work-order-installations`
- `/checklist-templates`
- `/checklist-template-items`
- `/checklist-answers`
- `/measurements`
- `/defects`
- `/photos`
- `/time-entries`
- `/materials`
- `/work-order-materials`
- `/report-templates`
- `/reports`

Each route supports `GET`, `POST`, `GET /:id`, `PATCH /:id`, and `DELETE /:id`. Deletes are soft deletes. Updates increment `version`.

## Reports

- `POST /reports/generate`
- `GET /reports/:id`

Report generation creates server-side report metadata and links it to a work order. PDF bytes remain in the mobile/local file flow until uploaded through `/files/upload/*`.

Tenant-specific report templates are managed through `/report-templates` and
sync through `report_templates`. A template can define the report title prefix,
locale marker, primary color, footer text, default status, and section switches
for customer/object data, installations, measurements, defects, materials, time
entries, photos, and signature blocks. Mobile PDF generation uses the active
default template for the current tenant and falls back to the standard report
layout when no template is available.
