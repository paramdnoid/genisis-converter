#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../mobile"
flutter analyze
flutter test

android_device_id="$(flutter devices --machine | awk -F'"' '/"id":/ { id=$4 } /"targetPlatform": "android/ { print id; exit }')"
if [[ -n "$android_device_id" ]]; then
  flutter test integration_test -d "$android_device_id"
else
  echo "Skipping device integration tests: no Android device or emulator connected."
fi

cd ../backend
npm run prisma:generate
npx prisma validate
npm run build
npm test
