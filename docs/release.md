# Release

This project uses Dart-defined runtime flavors first. Native release metadata is
set for the mobile app. Store accounts, Apple signing team selection, and actual
track/TestFlight uploads still need real Apple/Google account access before
public beta release.

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

Remote push registration is enabled only when Firebase runtime values are
present. The build scripts forward these optional environment variables as Dart
defines when they are set:

```bash
FIREBASE_API_KEY=...
FIREBASE_APP_ID=...
FIREBASE_MESSAGING_SENDER_ID=...
FIREBASE_PROJECT_ID=...
FIREBASE_IOS_BUNDLE_ID=...
APP_VERSION=1.0.0+1
TENANT_SLUG=demo-kaminfeger
```

`TENANT_SLUG` is optional but recommended for SaaS deployments where the same
technician email can exist in multiple tenant accounts.

## Build Commands

Android APK smoke build:

```bash
scripts/build_android.sh staging
```

Android App Bundle for Google Play Internal Testing:

```bash
scripts/build_android_bundle.sh prod
```

iOS simulator smoke build:

```bash
scripts/build_ios_simulator.sh dev
```

TestFlight archive:

```bash
scripts/build_ios_archive.sh prod
```

Both scripts accept `dev`, `staging`, or `prod` and forward the matching
Dart defines to Flutter.

## Android Release Checklist

- App name: `Kaminfeger Mobile`, set in
  `mobile/android/app/src/main/AndroidManifest.xml`.
- Package name/application ID: `ch.kaminfeger.mobile`, set in
  `mobile/android/app/build.gradle.kts`.
- App icon: generated from `mobile/assets/icons/app_icon.svg` into Android
  launcher mipmaps.
- Version: controlled by `mobile/pubspec.yaml` `version: 1.0.0+1`.
- Signing: copy `mobile/android/key.properties.example` to
  `mobile/android/key.properties` and fill real local or CI secret values. The
  real file is ignored by git. `scripts/build_android_bundle.sh` fails early
  when these release signing values are missing so Internal Testing artifacts
  are not accidentally built with debug signing.
- R8/Proguard: reviewed and intentionally disabled for now in
  `mobile/android/app/build.gradle.kts`; Flutter/Dart tree-shaking remains
  active. Enable R8 only when native SDK keep rules are known.
- Internal Testing: build `scripts/build_android_bundle.sh prod`, then upload
  `mobile/build/app/outputs/bundle/release/app-release.aab` to the Google Play
  Internal Testing track after account access is configured.
- Push notifications: set the Firebase Dart-define environment variables before
  building a signed artifact. Without them the app skips FCM token registration
  and remains offline/test safe.

## iOS Release Checklist

- Bundle identifier: `ch.kaminfeger.mobile`, set in
  `mobile/ios/Runner.xcodeproj/project.pbxproj`.
- Display name: `Kaminfeger Mobile`; short bundle name: `Kaminfeger`, set in
  `mobile/ios/Runner/Info.plist`.
- App icon: generated from `mobile/assets/icons/app_icon.svg` into the iOS
  AppIcon asset catalog.
- Launch screen: `LaunchScreen.storyboard` references the branded LaunchImage
  asset set.
- Signing team: `mobile/ios/Flutter/Signing.xcconfig` reads
  `IOS_DEVELOPMENT_TEAM` from the ignored local file
  `mobile/ios/Flutter/Signing.local.xcconfig`. Copy the checked-in example and
  set the real Apple Developer Team ID before running a device/TestFlight
  archive.
- Capabilities: camera, photos, location, networking, Bluetooth, and remote
  notification background mode are covered by Info.plist permission prompts and
  plugin usage. A real Apple Push Notifications entitlement must be enabled in
  the Apple Developer portal for TestFlight push delivery.
- TestFlight: after signing team setup, run `scripts/build_ios_archive.sh prod`
  and upload the generated IPA through Transporter, Xcode Organizer, or CI.
- Push notifications: set the Firebase Dart-define environment variables before
  archiving, and ensure the Firebase iOS app is connected to APNs.

## Current Build Validation

- Android release APK smoke build validated with `scripts/build_android.sh dev`.
- Android App Bundle path validates release-signing configuration before build;
  real Google Play upload still needs release keystore and account access.
- iOS simulator smoke build validated with `scripts/build_ios_simulator.sh dev`.
- iOS archive path validates the local Apple Team ID before build; real
  TestFlight upload still needs Apple Developer account access.

## Assets

The checked-in source for native app icons is
`mobile/assets/icons/app_icon.svg`. Regenerate the Android and iOS raster assets
from that source whenever the brand mark changes, then run Android and iOS smoke
builds.
