# Data Model

All business tables are tenant-aware and will share the following fields:

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

The first Drift implementation will cover tenants, users, customers, objects, installations, work orders, checklist templates, checklist answers, measurements, defects, photos, time entries, materials, reports, outbox entries, and sync state.
