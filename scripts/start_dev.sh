#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKEND_DIR="$ROOT_DIR/backend"
MOBILE_DIR="$ROOT_DIR/mobile"

START_MOBILE="${START_MOBILE:-auto}"
RUN_SETUP="${RUN_SETUP:-auto}"
RUN_MIGRATIONS="${RUN_MIGRATIONS:-1}"
MIGRATION_MODE="${MIGRATION_MODE:-deploy}"
RUN_SEED="${RUN_SEED:-1}"
DEVICE_ID="${DEVICE_ID:-}"
PREFER_IOS_SIMULATOR="${PREFER_IOS_SIMULATOR:-0}"
START_PRISMA_STUDIO="${START_PRISMA_STUDIO:-0}"
BACKEND_PID=""
STUDIO_PID=""

usage() {
  cat <<'USAGE'
Usage: scripts/start_dev.sh [options]

Starts the local development stack:
  - PostgreSQL from backend/docker-compose.yml
  - Prisma generate + migrations + seed
  - NestJS backend in watch mode
  - Flutter app when a device is available or requested

Options:
  --backend-only, --no-mobile  Start database + backend only
  --mobile                     Force Flutter run
  --device <id>                Pass a Flutter device id, e.g. chrome or emulator-5554
  --android                    Shortcut for --device android
  --ios, --ios-simulator       Boot and run an iOS simulator without code signing
  --chrome                     Shortcut for --device chrome
  --studio                     Start Prisma Studio too
  --skip-setup                 Skip npm install / flutter pub get
  --setup                      Force npm install / flutter pub get
  --skip-migrate               Skip Prisma migrations
  --migrate-dev                Use prisma migrate dev instead of migrate deploy
  --skip-seed                  Skip prisma seed
  -h, --help                   Show this help

Useful env overrides:
  API_BASE_URL=http://localhost:3000
  PORT=3000
  DEVICE_ID=chrome
  IOS_SIMULATOR_DEVICE_ID=<simulator-udid>
  PREFER_IOS_SIMULATOR=1|0
  START_MOBILE=auto|1|0
  RUN_SETUP=auto|1|0
  RUN_MIGRATIONS=1|0
  MIGRATION_MODE=deploy|dev
  RUN_SEED=1|0
  TENANT_SLUG=demo-kaminfeger
USAGE
}

log() {
  printf '\n[%s] %s\n' "$(date '+%H:%M:%S')" "$*"
}

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

cleanup() {
  local exit_code=$?

  if [[ -n "$STUDIO_PID" ]] && kill -0 "$STUDIO_PID" 2>/dev/null; then
    log "Stopping Prisma Studio (pid $STUDIO_PID)"
    kill "$STUDIO_PID" 2>/dev/null || true
    wait "$STUDIO_PID" 2>/dev/null || true
  fi

  if [[ -n "$BACKEND_PID" ]] && kill -0 "$BACKEND_PID" 2>/dev/null; then
    log "Stopping backend (pid $BACKEND_PID)"
    kill "$BACKEND_PID" 2>/dev/null || true
    wait "$BACKEND_PID" 2>/dev/null || true
  fi

  exit "$exit_code"
}

trap cleanup EXIT INT TERM

read_env_value() {
  local key="$1"
  local file="$2"

  [[ -f "$file" ]] || return 0

  awk -F= -v key="$key" '
    $1 == key {
      value = substr($0, index($0, "=") + 1)
      gsub(/^["'\'' ]+|["'\'' ]+$/, "", value)
      print value
      exit
    }
  ' "$file"
}

wait_for_postgres() {
  log "Waiting for PostgreSQL"
  for _ in {1..60}; do
    if docker compose exec -T postgres pg_isready -U postgres -d kaminfeger >/dev/null 2>&1; then
      log "PostgreSQL is ready"
      return 0
    fi
    sleep 1
  done

  die "PostgreSQL did not become ready in time"
}

wait_for_backend() {
  local url="$1"

  log "Waiting for backend at $url"
  for _ in {1..60}; do
    if ! kill -0 "$BACKEND_PID" 2>/dev/null; then
      die "Backend process exited before it became ready"
    fi

    if curl -fsS "$url" >/dev/null 2>&1; then
      log "Backend is ready"
      return 0
    fi
    sleep 1
  done

  die "Backend did not become ready in time"
}

flutter_device_field() {
  local field="$1"

  flutter devices --machine 2>/dev/null \
    | tr '{' '\n' \
    | awk -F'"' -v field="$field" '
        {
          for (i = 1; i <= NF; i++) {
            if ($i == field) {
              print $(i + 2)
              exit
            }
          }
        }
      '
}

has_flutter_device() {
  [[ -n "$(flutter_device_field id)" ]]
}

is_android_target() {
  local device_id="$1"
  local target_platform="$2"

  [[ "$device_id" == android* || "$device_id" == emulator-* || "$target_platform" == android* ]]
}

ios_simulator_id() {
  local requested_device_id="${IOS_SIMULATOR_DEVICE_ID:-}"
  local simulator_id
  local devices

  command_exists xcrun || die "xcrun is required for iOS simulator startup"

  if [[ -n "$requested_device_id" ]]; then
    printf '%s\n' "$requested_device_id"
    return 0
  fi

  devices="$(xcrun simctl list devices available)"

  simulator_id="$(printf '%s\n' "$devices" \
    | sed -nE 's/^[[:space:]]*iPhone.*\(([0-9A-F-]{36})\) \(Booted\).*$/\1/p' \
    | head -n 1)"
  if [[ -n "$simulator_id" ]]; then
    printf '%s\n' "$simulator_id"
    return 0
  fi

  printf '%s\n' "$devices" \
    | sed -nE 's/^[[:space:]]*iPhone.*\(([0-9A-F-]{36})\) \(Shutdown\).*$/\1/p' \
    | head -n 1
}

boot_ios_simulator() {
  local simulator_id="$1"

  [[ -n "$simulator_id" ]] || die "No available iOS simulator found"

  log "Booting iOS simulator $simulator_id"
  xcrun simctl boot "$simulator_id" >/dev/null 2>&1 || true
  open -a Simulator --args -CurrentDeviceUDID "$simulator_id" >/dev/null 2>&1 || open -a Simulator
  xcrun simctl bootstatus "$simulator_id" -b >/dev/null
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --backend-only|--no-mobile)
      START_MOBILE=0
      shift
      ;;
    --mobile)
      START_MOBILE=1
      shift
      ;;
    --device)
      [[ $# -ge 2 ]] || die "--device requires a value"
      DEVICE_ID="$2"
      START_MOBILE=1
      shift 2
      ;;
    --android)
      DEVICE_ID="android"
      START_MOBILE=1
      shift
      ;;
    --ios|--ios-simulator)
      PREFER_IOS_SIMULATOR=1
      START_MOBILE=1
      shift
      ;;
    --chrome)
      DEVICE_ID="chrome"
      START_MOBILE=1
      shift
      ;;
    --studio)
      START_PRISMA_STUDIO=1
      shift
      ;;
    --skip-setup)
      RUN_SETUP=0
      shift
      ;;
    --setup)
      RUN_SETUP=1
      shift
      ;;
    --skip-migrate)
      RUN_MIGRATIONS=0
      shift
      ;;
    --migrate-dev)
      MIGRATION_MODE=dev
      shift
      ;;
    --skip-seed)
      RUN_SEED=0
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "Unknown option: $1"
      ;;
  esac
done

command_exists docker || die "Docker is required"
docker compose version >/dev/null 2>&1 || die "Docker Compose v2 is required"
command_exists npm || die "npm is required"
command_exists curl || die "curl is required"

if [[ "$START_MOBILE" != "0" ]]; then
  command_exists flutter || die "Flutter is required when mobile startup is enabled"
fi

if [[ ! -f "$BACKEND_DIR/.env" ]]; then
  log "Creating backend/.env from backend/.env.example"
  cp "$BACKEND_DIR/.env.example" "$BACKEND_DIR/.env"
fi

BACKEND_PORT="${PORT:-$(read_env_value PORT "$BACKEND_DIR/.env")}"
BACKEND_PORT="${BACKEND_PORT:-3000}"
export NODE_ENV="${NODE_ENV:-development}"
export LOG_LEVEL="${LOG_LEVEL:-debug}"
export SYNC_DEBUG_LOGGING="${SYNC_DEBUG_LOGGING:-true}"

if [[ "$RUN_SETUP" == "1" || ( "$RUN_SETUP" == "auto" && ! -d "$BACKEND_DIR/node_modules" ) ]]; then
  log "Installing backend dependencies"
  (cd "$BACKEND_DIR" && npm install)
fi

if [[ "$RUN_SETUP" == "1" || ( "$RUN_SETUP" == "auto" && ! -d "$MOBILE_DIR/.dart_tool" ) ]]; then
  log "Resolving Flutter dependencies"
  (cd "$MOBILE_DIR" && flutter pub get)
fi

log "Starting PostgreSQL"
(cd "$BACKEND_DIR" && docker compose up -d postgres)
(cd "$BACKEND_DIR" && wait_for_postgres)

log "Preparing Prisma"
(cd "$BACKEND_DIR" && npm run prisma:generate)

if [[ "$RUN_MIGRATIONS" == "1" ]]; then
  if [[ "$MIGRATION_MODE" == "dev" ]]; then
    log "Applying Prisma migrations with migrate dev"
    (cd "$BACKEND_DIR" && npm run prisma:migrate -- --skip-seed)
  else
    log "Applying Prisma migrations with migrate deploy"
    (cd "$BACKEND_DIR" && npm run prisma:deploy)
  fi
fi

if [[ "$RUN_SEED" == "1" ]]; then
  log "Seeding backend demo data"
  (cd "$BACKEND_DIR" && npm run seed)
fi

if [[ "$START_PRISMA_STUDIO" == "1" ]]; then
  log "Starting Prisma Studio"
  (cd "$BACKEND_DIR" && npm run prisma:studio) &
  STUDIO_PID=$!
fi

log "Starting backend on port $BACKEND_PORT"
(cd "$BACKEND_DIR" && npm run start:dev) &
BACKEND_PID=$!
wait_for_backend "http://localhost:$BACKEND_PORT/health"

log "Demo login: admin@example.invalid / admin1234"
log "Backend health: http://localhost:$BACKEND_PORT/health"

if [[ "$START_MOBILE" == "auto" ]]; then
  if has_flutter_device; then
    START_MOBILE=1
  else
    START_MOBILE=0
    log "No Flutter device detected; backend stays running. Use --mobile --device <id> to force Flutter."
  fi
fi

if [[ "$START_MOBILE" == "1" ]]; then
  if [[ "$PREFER_IOS_SIMULATOR" == "1" ]]; then
    DEVICE_ID="$(ios_simulator_id)"
    boot_ios_simulator "$DEVICE_ID"
  fi

  if [[ -z "$DEVICE_ID" ]]; then
    DEVICE_ID="$(flutter_device_field id)"
  fi

  if [[ -z "$DEVICE_ID" ]]; then
    die "No Flutter device available. Run flutter devices or pass --backend-only."
  fi

  target_platform="$(flutter_device_field targetPlatform)"
  if [[ -z "${API_BASE_URL:-}" ]]; then
    if is_android_target "$DEVICE_ID" "$target_platform"; then
      API_BASE_URL="http://10.0.2.2:$BACKEND_PORT"
    else
      API_BASE_URL="http://localhost:$BACKEND_PORT"
    fi
  fi

  log "Starting Flutter on device $DEVICE_ID with API_BASE_URL=$API_BASE_URL"
  cd "$MOBILE_DIR"
  flutter run \
    -d "$DEVICE_ID" \
    --dart-define=APP_ENV=development \
    --dart-define=API_BASE_URL="$API_BASE_URL" \
    --dart-define=LOG_LEVEL="${LOG_LEVEL:-debug}" \
    --dart-define=SYNC_DEBUG_LOGGING="${SYNC_DEBUG_LOGGING:-true}" \
    --dart-define=ENFORCE_HTTPS=false \
    --dart-define=TENANT_SLUG="${TENANT_SLUG:-demo-kaminfeger}"
else
  log "Backend is running. Press Ctrl-C to stop it."
  wait "$BACKEND_PID"
fi
