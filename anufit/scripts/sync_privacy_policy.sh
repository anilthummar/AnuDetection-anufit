#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

SRC="assets/legal/privacy_policy.html"
DEST_DIR="docs/compliance/hosting/privacy"
DEST="$DEST_DIR/index.html"

if [[ ! -f "$SRC" ]]; then
  echo "Missing source: $SRC"
  exit 1
fi

mkdir -p "$DEST_DIR"
cp "$SRC" "$DEST"

# Remove developer-only footer line from the public hosted copy.
sed -i '' '/Host this policy at the web URL above/d' "$DEST" 2>/dev/null || \
  sed -i '/Host this policy at the web URL above/d' "$DEST"

echo "Synced $SRC → $DEST"
echo "Deploy docs/compliance/hosting/privacy/ to your static host."
