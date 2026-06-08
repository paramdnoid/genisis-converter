# Data Model

The backend Prisma schema in `backend/prisma/schema.prisma` and initial migration in `backend/prisma/migrations/20260608000000_initial_backend/migration.sql` implement the mobile/backend data model for PostgreSQL. Business tables are tenant-aware and share the following fields where applicable:

```text
id TEXT PRIMARY KEY
tenant_id TEXT NOT NULL
created_at TEXT NOT NULL
updated_at TEXT NOT NULL
deleted_at TEXT NULL
version INTEGER NOT NULL DEFAULT 1
sync_status TEXT NOT NULL DEFAULT 'synced'
last_synced_at TEXT NULL
```

Implemented backend models:

- `Tenant`
- `User`
- `Customer`
- `CustomerObject`
- `Installation`
- `WorkOrder`
- `WorkOrderInstallation`
- `ChecklistTemplate`
- `ChecklistTemplateItem`
- `ChecklistAnswer`
- `Measurement`
- `Defect`
- `Photo`
- `TimeEntry`
- `Material`
- `WorkOrderMaterial`
- `Report`
- `FileUpload`
- `SyncOutboxEntry`
- `AuditLog`

`SyncOutboxEntry` stores processed mobile outbox IDs for idempotent push replay. `AuditLog` records sync and file-completion events.
