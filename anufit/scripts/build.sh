#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

FLAVOR="${1:-dev}"
TARGET="${2:-apk}"

echo "Building Anufit (flavor: $FLAVOR, target: $TARGET)..."

case "$TARGET" in
  apk)
    flutter build apk --dart-define=ENV="$FLAVOR"
    ;;
  appbundle | aab)
    flutter build appbundle --dart-define=ENV="$FLAVOR"
    ;;
  ios)
    flutter build ios --dart-define=ENV="$FLAVOR"
    ;;
  *)
    echo "Unknown target: $TARGET (use apk, appbundle, or ios)"
    exit 1
    ;;
esac

echo "Build complete."
