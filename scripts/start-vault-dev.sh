#!/usr/bin/env bash
set -euo pipefail

export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN='root'

echo "VAULT_ADDR=$VAULT_ADDR"
echo "VAULT_TOKEN=$VAULT_TOKEN"
echo "Démarrage de Vault en mode développement..."
vault server -dev
