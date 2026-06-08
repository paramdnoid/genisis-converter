# Architecture

The app is offline-first. The mobile SQLite database will become the primary working store, while the backend is used for authentication, synchronization, central planning, and file storage.

## Layers

- `features/`: UI and feature-specific presentation logic.
- `domain/`: entities, enums, value objects, repository contracts, and use cases.
- `data/`: Drift database, API clients, repository implementations, local files, and sync services.
- `core/`: app-wide configuration, routing, theme, error handling, logging, networking, constants, and utilities.

## Backend

The backend lives in `backend/` and uses NestJS with Prisma/PostgreSQL.

Implemented backend layers:

- `AuthModule` for login, refresh, logout, and `/me`.
- Global JWT guard plus tenant middleware for server-side tenant isolation.
- `EntitiesModule` for tenant-scoped REST CRUD routes across the domain model.
- `ReportsModule` for report metadata generation and report CRUD.
- `FilesModule` for upload init/PUT/complete metadata flow.
- `SyncModule` for cursor pull, idempotent push, conflict detection, soft deletes, and audit logging.
- `PrismaModule` for database access and lifecycle management.

## First Milestone

The initial milestone establishes the runnable Flutter shell with a predictable folder layout, theme, router, splash, login placeholder, and dashboard placeholder.
