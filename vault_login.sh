#!/bin/bash

VAULT_ROLE_NAME="$1"

if [ -z "$VAULT_ROLE_NAME" ]; then
  echo "error: vault role name is required. usage: ./vault_login.sh <vault-role-name>"
  exit 1
fi

RESPONSE=$(curl -s -X POST \
  --cert "$PKI_CERT" \
  --key "$PKI_KEY" \
  --cacert "$PKI_CA" \
  https://vault-stg.cermati.com:9443/v1/auth/cert/login \
  --data "{\"name\": \"$VAULT_ROLE_NAME\"}")

CLIENT_TOKEN=$(echo "$RESPONSE" | jq -r '.auth.client_token')

if [ -z "$CLIENT_TOKEN" ] || [ "$CLIENT_TOKEN" = "null" ]; then
  echo "failed to copy client_token to clipboard"
  exit 1
fi

if command -v pbcopy &>/dev/null; then
  echo "$CLIENT_TOKEN" | pbcopy
elif command -v xclip &>/dev/null; then
  echo "$CLIENT_TOKEN" | xclip -selection clipboard
elif command -v xsel &>/dev/null; then
  echo "$CLIENT_TOKEN" | xsel --clipboard --input
elif command -v wl-copy &>/dev/null; then
  echo "$CLIENT_TOKEN" | wl-copy
else
  echo "client_token: $CLIENT_TOKEN"
  echo "warning: no clipboard tool found (install xclip, xsel, or wl-clipboard on Linux)"
  exit 1
fi

echo "client_token copied to clipboard"
