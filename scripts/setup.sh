#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../mobile"
flutter pub get

cd ../backend
npm install
npm run prisma:generate
