# Release

This project uses Dart-defined runtime flavors first. Native store metadata,
signing teams, and store tracks still need real Apple/Google account values
before public beta release.

## Flavors

| Flavor | Dart define | API default | HTTPS |
|---|---|---|---|
| Development | `APP_ENV=dev` | `https://api.example.invalid` | optional |
| Staging | `APP_ENV=staging` | `https://staging-api.example.invalid` | required |
| Production | `APP_ENV=prod` | `https://api.example.invalid` | required |

Runtime configuration is implemented in
`mobile/lib/core/config/app_environment.dart` and can be overridden with:

```bash
--dart-define=APP_ENV=staging
--dart-define=API_BASE_URL=https://staging.example.ch
--dart-define=LOG_LEVEL=info
--dart-define=ENFORCE_HTTPS=true
```

## Build Commands

Android APK smoke build:

```bash
scripts/build_android.sh staging
```

iOS simulator smoke build:

```bash
scripts/build_ios_simulator.sh dev
```

Both scripts accept `dev`, `staging`, or `prod` and forward the matching
Dart defines to Flutter.

## Android Release Checklist

- App name: set in `mobile/android/app/src/main/AndroidManifest.xml`.
- Package name: currently `ch.example.kaminfeger.kaminfeger_mobile`; change
  only when the final organization identifier is known.
- Version: controlled by `mobile/pubspec.yaml` `version: 1.0.0+1`.
- Signing: add upload keystore through local CI/store secrets, never commit it.
- R8/Proguard: keep Flutter defaults until backend SDKs or native libraries
  require explicit keep rules.
- Internal Testing: create the Google Play track after package name, icon, and
  signing are final.

## iOS Release Checklist

- Bundle identifier: currently generated from the Flutter project org; change
  only when the final Apple team identifier is known.
- Display name: set through Xcode project settings before TestFlight.
- Signing team: configure locally or in CI with Apple secrets.
- Capabilities: camera, photos, location, and networking are covered by current
  permission prompts; review again before TestFlight.
- TestFlight: prepare an archive only after signing team and bundle identifier
  are final.

## Assets

App icons and launch screens are still placeholders. Replace them before store
submission and run both Android and iOS smoke builds afterwards.
