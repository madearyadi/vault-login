# vault_login.sh

Logs into Vault using PKI certificate auth and copies the `client_token` to clipboard.

## Prerequisites

The following environment variables must be exported before running:

| Variable | Description | Example |
|----------|-------------|---------|
| `PKI_CERT` | Path to your PKI certificate file | `/etc/pki/tls/certs/client.crt` |
| `PKI_KEY` | Path to your PKI private key file | `/etc/pki/tls/private/client.key` |
| `PKI_CA` | Path to the CA certificate file | `/etc/pki/ca-trust/source/anchors/ca.crt` |

### Example export

```bash
export PKI_CERT=/etc/pki/tls/certs/client.crt
export PKI_KEY=/etc/pki/tls/private/client.key
export PKI_CA=/etc/pki/ca-trust/source/anchors/ca.crt
```

## Usage

```bash
./vault_login.sh <vault-role-name>
```

### Example

```bash
./vault_login.sh cermati-simpsons-stellar-stg
```

## Output

- On success: `client_token copied to clipboard`
- On failure (empty role name): `error: vault role name is required. usage: ./vault_login.sh <vault-role-name>`
- On failure (token not found): `failed to copy client_token to clipboard`
- On failure (clipboard error): `failed to copy client_token to clipboard`
