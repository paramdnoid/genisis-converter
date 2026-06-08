#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../mobile"
flutter analyze
flutter test

cd ../backend
npm run build
npm test
