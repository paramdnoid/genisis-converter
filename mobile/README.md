# Kaminfeger Mobile

Offline-first Flutter app for Kaminfeger technicians.

## Development

```bash
flutter pub get
dart run build_runner build
dart format .
flutter analyze
flutter test
```

## Implemented Local MVP

- Drift/SQLite offline database with development seed data
- Work orders, checklists, measurements, defects, photos, signatures, times, material usage, reports, search, settings, and sync status screens
- Outbox-based local writes and demo sync processor
- PDF rapport generation and preview
- Secure-storage auth shell with demo fallback

Backend API integration is scaffolded but not connected to a production server yet.
