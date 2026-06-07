# Kaminfeger Techniker App

Offline-first mobile app for chimney sweep technicians on iOS and Android.

The repository follows the roadmap in [app.md](app.md). The current implementation covers Block A and the dependency setup from Prompt 2: a Flutter app shell, base architecture folders, routing, theme, placeholder screens, documentation stubs, validation scripts, and the mobile dependency graph for the upcoming offline-first implementation.

## Stack

- Flutter and Dart for the mobile app
- GoRouter for navigation
- Riverpod as the state-management foundation
- Drift/SQLite, Dio, code generation, connectivity, secure storage, camera/file access, PDF, printing, signatures, geolocation, and permissions are installed for the upcoming roadmap blocks
- Local database schema, sync, reports, signatures, and backend API integration are not implemented yet

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
- Login and dashboard are placeholders only.
- Offline-first persistence, sync, authentication, reports, and domain workflows are not implemented yet.
- Native debug builds have been validated for Android APK and iOS Simulator with the current dependency set.
- No secrets are required for the current app shell. Copy `.env.example` only when backend/API work begins.
