#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

echo "Cleaning Anufit project..."

flutter clean
rm -rf build/ coverage/ .dart_tool/

echo "Clean complete. Run 'flutter pub get' before building."
