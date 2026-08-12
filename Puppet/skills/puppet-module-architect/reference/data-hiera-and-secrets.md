# Data, Hiera, And Secrets

## Hiera strategy

- Use Hiera v5 with explicit hierarchy.
- Keep defaults in data/common.yaml and environment-specific overrides in separate layers.
- Use lookup_options to control merge behavior.

## Data contracts

- Define expected structure for looked-up data in class parameter types.
- Use Struct and Optional to make assumptions explicit.
- Fail early when data shape does not match contract.

## Secret handling

- Never commit secrets in data files.
- Use a secret backend (for example eyaml, Vault, or cloud secret store) with environment-specific policy.
- Limit secret exposure in templates, logs, and reports.
- Document secret rotation and access review process in SECURITY.md.

## Facts and external data trust

- Treat custom facts and external facts as untrusted.
- Validate and normalize before use.
- Avoid interpolating untrusted values directly in command strings.
