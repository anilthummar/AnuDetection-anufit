#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

echo "Running code generation..."

flutter pub get
dart run build_runner build --delete-conflicting-outputs

echo "Code generation complete."
