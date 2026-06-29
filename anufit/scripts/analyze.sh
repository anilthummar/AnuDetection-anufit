#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

echo "Analyzing Anufit..."

flutter pub get
dart analyze --fatal-infos
flutter analyze

echo "Analysis complete."
