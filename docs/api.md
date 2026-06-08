# API

The backend API is implemented in `backend/` with NestJS, Prisma, JWT auth, and PostgreSQL.

## Auth

- `POST /auth/login`
- `POST /auth/refresh`
- `POST /auth/logout`
- `GET /me`

All routes except `/health`, `/auth/login`, and `/auth/refresh` require a bearer access token. The token contains `sub`, `tenantId`, `email`, and `role`. The optional `x-tenant-id` header must match the token tenant.

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
- `/reports`

Each route supports `GET`, `POST`, `GET /:id`, `PATCH /:id`, and `DELETE /:id`. Deletes are soft deletes. Updates increment `version`.

## Reports

- `POST /reports/generate`
- `GET /reports/:id`

Report generation creates server-side report metadata and links it to a work order. PDF bytes remain in the mobile/local file flow until uploaded through `/files/upload/*`.
