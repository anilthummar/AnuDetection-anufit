#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

dart run pigeon --input pigeons/step_counter_api.dart

echo "Pigeon codegen complete."
