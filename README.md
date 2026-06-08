# Kaminfeger Techniker App

[![mobile-ci](https://github.com/paramdnoid/genisis-converter/actions/workflows/mobile-ci.yml/badge.svg)](https://github.com/paramdnoid/genisis-converter/actions/workflows/mobile-ci.yml)

Offline-first mobile app for chimney sweep technicians on iOS and Android.

The repository follows the roadmap in [app.md](app.md). The current implementation covers the Flutter app shell, core architecture folders, routing, theme, documentation stubs, validation scripts, the mobile dependency graph, and an offline-first local MVP with Drift/SQLite, seed data, DAOs, repositories/use cases, dashboard data, work-order list/detail, dynamic checklists, measurements, defects, photos, signatures, time entries, material usage, PDF reports, search, settings, and sync status.

## Stack

- Flutter and Dart for the mobile app
- GoRouter for navigation
- Riverpod as the state-management foundation
- Drift/SQLite, Dio, code generation, connectivity, secure storage, camera/file access, PDF, printing, signatures, geolocation, permissions, and URL launching are installed for the roadmap blocks
- Local database schema, DAOs, development seed data, outbox tracking, feature repositories, work-order list/detail, dynamic checklists, measurements, defects, photos, signatures, time entries, material usage, report generation, settings/search, permission flows, and a local sync processor are implemented
- Backend API integration remains a demo shell until the backend project is implemented

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
- Login uses a demo-capable auth controller with secure-storage persistence when available.
- Dashboard reads today's seeded local work orders from Drift.
- The work-order list supports local search, status filters, and navigation into local details.
- The detail view shows joined customer, object, and installation data plus local start/pause/resume/complete actions.
- Starting/pausing/resuming/completing a work order writes local outbox entries and creates/closes work time entries.
- Checklists are generated from local templates and support yes/no, text, number, single-select, multi-select, photo-required acknowledgement, autosave, comments, required validation, and progress display.
- Measurements, defects, photos, signatures, times, material usage, and PDF reports can be captured offline with local persistence and outbox entries.
- Sync services process local outbox entries against a local demo push/file-upload implementation; real backend endpoints remain open.
- Native debug builds have been validated for Android APK and iOS Simulator with the current dependency set.
- No secrets are required for the current app shell. Copy `.env.example` only when backend/API work begins.
