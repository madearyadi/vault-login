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

Add the following exports to your shell config file and restart your terminal (or run `source <file>`).

**macOS** — add to `~/.zshrc` (default shell) or `~/.bash_profile` if using bash:

```bash
export PKI_CERT=/path/to/client.crt
export PKI_KEY=/path/to/client.key
export PKI_CA=/path/to/ca.crt
```

**Linux** — add to `~/.bashrc` (bash) or `~/.zshrc` (zsh):

```bash
export PKI_CERT=/path/to/client.crt
export PKI_KEY=/path/to/client.key
export PKI_CA=/path/to/ca.crt
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
