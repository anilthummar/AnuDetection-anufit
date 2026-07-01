#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

echo "Preparing transparent foreground + notification assets..."
python3 scripts/prepare_branding_assets.py

echo "Generating launcher icons and native splash..."
dart run flutter_launcher_icons
dart run flutter_native_splash:create

echo "Flattening splash images onto brand background..."
python3 scripts/prepare_branding_assets.py --flatten-splash

echo "Branding assets generated."
