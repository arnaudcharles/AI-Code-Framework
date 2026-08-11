# Compose and Runtime Guidance

## Compose baseline

- Use `compose.yaml` with explicit service names.
- Keep one concern per service.
- Use named volumes and explicit networks.
- Keep local overrides in `compose.override.yaml` (not committed if environment-specific).

## Runtime contracts

For each service define and document:
- Required and optional env vars
- Exposed ports
- Volume paths
- Startup command and healthcheck endpoint
- Restart policy and shutdown behavior

## Security-focused service defaults

Prefer these when compatible:
- `user: "10001:10001"`
- `read_only: true`
- `tmpfs` for writable temp paths
- `cap_drop: ["ALL"]`
- `security_opt: ["no-new-privileges:true"]`

## Secrets and config

- Keep plaintext secrets out of compose files.
- Use Compose `secrets:` for file-based secret injection.
- Use env files only for non-sensitive defaults.

## Operational resilience

- Add `healthcheck` for every long-running service.
- Set sane `restart` policy.
- Use dependency conditions carefully; healthchecks are preferred to start-order assumptions.

## Resource controls

- Define CPU and memory constraints where runtime supports them.
- Make defaults explicit to avoid noisy-neighbor issues.
