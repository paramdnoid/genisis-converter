#!/usr/bin/env bash
set -euo pipefail

FLAVOR="${1:-dev}"

case "$FLAVOR" in
  dev|development)
    APP_ENV="dev"
    API_BASE_URL="${API_BASE_URL:-https://api.example.invalid}"
    LOG_LEVEL="${LOG_LEVEL:-debug}"
    ENFORCE_HTTPS="${ENFORCE_HTTPS:-false}"
    ;;
  staging|stage)
    APP_ENV="staging"
    API_BASE_URL="${API_BASE_URL:-https://staging-api.example.invalid}"
    LOG_LEVEL="${LOG_LEVEL:-info}"
    ENFORCE_HTTPS="${ENFORCE_HTTPS:-true}"
    ;;
  prod|production)
    APP_ENV="prod"
    API_BASE_URL="${API_BASE_URL:-https://api.example.invalid}"
    LOG_LEVEL="${LOG_LEVEL:-warning}"
    ENFORCE_HTTPS="${ENFORCE_HTTPS:-true}"
    ;;
  *)
    echo "Usage: $0 [dev|staging|prod]" >&2
    exit 64
    ;;
esac

firebase_defines=()
for key in \
  FIREBASE_API_KEY \
  FIREBASE_APP_ID \
  FIREBASE_MESSAGING_SENDER_ID \
  FIREBASE_PROJECT_ID \
  FIREBASE_IOS_BUNDLE_ID \
  APP_VERSION \
  TENANT_SLUG; do
  if [[ -n "${!key:-}" ]]; then
    firebase_defines+=(--dart-define="$key=${!key}")
  fi
done

cd "$(dirname "$0")/../mobile"
flutter build apk \
  --dart-define=APP_ENV="$APP_ENV" \
  --dart-define=API_BASE_URL="$API_BASE_URL" \
  --dart-define=LOG_LEVEL="$LOG_LEVEL" \
  --dart-define=ENFORCE_HTTPS="$ENFORCE_HTTPS" \
  "${firebase_defines[@]}"
