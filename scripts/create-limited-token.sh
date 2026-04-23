#!/usr/bin/env bash
set -euo pipefail

export VAULT_ADDR="${VAULT_ADDR:-http://127.0.0.1:8200}"
export VAULT_TOKEN="${VAULT_TOKEN:-root}"

vault policy write backend-policy policies/backend-policy.hcl
vault token create -policy='backend-policy' -ttl='24h'
