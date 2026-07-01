#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

FLAVOR="${1:-production}"
TARGET="${2:-apk}"

echo "Building Anufit (flavor: $FLAVOR, target: $TARGET)..."

if [[ "$FLAVOR" == "production" && ("$TARGET" == "appbundle" || "$TARGET" == "aab") ]]; then
  if [[ ! -f android/key.properties ]]; then
    echo "Error: android/key.properties is required for production app bundle builds."
    echo "Copy android/key.properties.example and configure your release keystore."
    exit 1
  fi
fi

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
