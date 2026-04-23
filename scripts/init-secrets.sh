#!/usr/bin/env bash
set -euo pipefail

export VAULT_ADDR="${VAULT_ADDR:-http://127.0.0.1:8200}"
export VAULT_TOKEN="${VAULT_TOKEN:-root}"

vault status >/dev/null

if ! vault secrets list | grep -q '^myapp/'; then
  vault secrets enable -path=myapp kv-v2
fi

vault kv put myapp/database \
  username='app_user' \
  password='S3cur3P@ss!' \
  url='postgresql://db.local:5432/myapp'

vault kv put myapp/api_keys \
  stripe='sk_test_xxxxx' \
  sendgrid='SG.xxxxx'

vault kv put myapp/dev \
  sample='demo'

echo "Secrets initialisés avec succès."
vault kv get myapp/database
