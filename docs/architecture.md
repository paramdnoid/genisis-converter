# Architecture

The app is offline-first. The mobile SQLite database will become the primary working store, while the backend is used for authentication, synchronization, central planning, and file storage.

## Layers

- `features/`: UI and feature-specific presentation logic.
- `domain/`: entities, enums, value objects, repository contracts, and use cases.
- `data/`: Drift database, API clients, repository implementations, local files, and sync services.
- `core/`: app-wide configuration, routing, theme, error handling, logging, networking, constants, and utilities.

## First Milestone

The initial milestone establishes the runnable Flutter shell with a predictable folder layout, theme, router, splash, login placeholder, and dashboard placeholder.
