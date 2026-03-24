#!/usr/bin/env bash
# destroy.sh — Destruction de l'infrastructure NovaSphere
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TF_DIR="${SCRIPT_DIR}/terraform/aws"

echo "=== Destruction de l'infrastructure ==="
cd "${TF_DIR}"
terraform destroy -auto-approve

echo "Infrastructure détruite."
