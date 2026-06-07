#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../mobile"
dart run build_runner build
