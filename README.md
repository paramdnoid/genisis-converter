# Kaminfeger Techniker App

Offline-first mobile app for chimney sweep technicians on iOS and Android.

The repository follows the roadmap in [app.md](app.md). The current implementation covers the Flutter app shell, core architecture folders, routing, theme, documentation stubs, validation scripts, the mobile dependency graph, and the first offline-first work-order slice with Drift/SQLite, seed data, DAOs, work-order repository/use cases, dashboard data, local list, detail view, dynamic checklists, and measurement capture.

## Stack

- Flutter and Dart for the mobile app
- GoRouter for navigation
- Riverpod as the state-management foundation
- Drift/SQLite, Dio, code generation, connectivity, secure storage, camera/file access, PDF, printing, signatures, geolocation, permissions, and URL launching are installed for the roadmap blocks
- Local database schema, DAOs, development seed data, outbox tracking for local work-order/checklist/measurement changes, work-order list, work-order detail, dynamic checklists, and measurements are implemented
- Full sync orchestration, authentication, reports, signatures, permission flows, and backend API integration are not implemented yet

## Structure

```text
mobile/      Flutter iOS/Android app
backend/     Backend placeholder for later implementation
docs/        Architecture, API, sync, data model, security, release notes
scripts/     Local setup, format, test, and generation helpers
```

## Local Setup

```bash
cd mobile
flutter pub get
dart run build_runner build
dart format .
flutter analyze
flutter test
```

Run the app:

```bash
cd mobile
flutter run
```

## Current State

- The app opens through a splash route.
- Login is still a placeholder.
- Dashboard reads today's seeded local work orders from Drift.
- The work-order list supports local search, status filters, and navigation into local details.
- The detail view shows joined customer, object, and installation data plus local start/pause/resume/complete actions.
- Starting/pausing/resuming/completing a work order writes local outbox entries and creates/closes work time entries.
- Checklists are generated from local templates and support yes/no, text, number, single-select, multi-select, photo-required acknowledgement, autosave, comments, required validation, and progress display.
- Measurements can be captured offline per work order with type-specific units, installation selection, plausibility validation, notes, local persistence, and outbox entries.
- Offline-first persistence is initialized; full sync, authentication, defects/photos, reports, signatures, and backend integration are still open.
- Native debug builds have been validated for Android APK and iOS Simulator with the current dependency set.
- No secrets are required for the current app shell. Copy `.env.example` only when backend/API work begins.
