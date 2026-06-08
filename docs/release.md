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
  real file is ignored by git.
- R8/Proguard: reviewed and intentionally disabled for now in
  `mobile/android/app/build.gradle.kts`; Flutter/Dart tree-shaking remains
  active. Enable R8 only when native SDK keep rules are known.
- Internal Testing: build `scripts/build_android_bundle.sh prod`, then upload
  `mobile/build/app/outputs/bundle/release/app-release.aab` to the Google Play
  Internal Testing track after account access is configured.

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
- Capabilities: no custom entitlements are required currently; camera, photos,
  location, and networking are covered by Info.plist permission prompts and
  plugin usage.
- TestFlight: after signing team setup, run `scripts/build_ios_archive.sh prod`
  and upload the generated IPA through Transporter, Xcode Organizer, or CI.

## Assets

The checked-in source for native app icons is
`mobile/assets/icons/app_icon.svg`. Regenerate the Android and iOS raster assets
from that source whenever the brand mark changes, then run Android and iOS smoke
builds.
