#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

COVERAGE="${1:-}"

echo "Running tests..."

flutter pub get

if [[ "$COVERAGE" == "--coverage" ]]; then
  flutter test --coverage
  echo "Coverage report: coverage/lcov.info"
else
  flutter test
fi

echo "Tests complete."
