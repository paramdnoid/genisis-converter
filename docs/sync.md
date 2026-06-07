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

The implementation will begin once the Drift schema and repositories are in place.
