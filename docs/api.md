# API

The backend API is planned but not implemented in this block.

## Planned Endpoints

- `POST /auth/login`
- `POST /auth/refresh`
- `POST /auth/logout`
- `GET /me`
- `GET /sync/pull?tenantId=:tenantId&entityType=:entityType&cursor=:cursor`
- `POST /sync/push`
- `POST /files/upload/init`
- `PUT /files/upload/:id`
- `POST /files/upload/complete`

Entity endpoints for customers, objects, installations, work orders, and reports will follow the contract in `app.md`.

## Sync Pull Response

The mobile client expects `/sync/pull` to return a cursor page:

```json
{
  "nextCursor": "opaque-server-cursor",
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

`entityType` may use the collection names from the local sync states
(`customers`, `work_orders`, etc.) or their singular entity names. Delete
changes can either set `operation` to `delete` or include `deletedAt`.
