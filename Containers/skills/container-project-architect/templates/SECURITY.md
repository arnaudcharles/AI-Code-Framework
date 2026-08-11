# SECURITY.md

## Security goals

- Prevent secret leakage in source, images, logs, and CI.
- Minimize container privileges and attack surface.
- Enforce supply-chain trust and traceability.
- Keep deployment and rollback safe and repeatable.

## Non-negotiable rules

- No secrets in repository, Dockerfile, or baked image layers.
- No floating image tags in production paths.
- Runtime containers must not run as root by default.
- Vulnerability scanning is mandatory in CI before release.
- Critical vulnerabilities require fix or time-bounded risk acceptance.

## Secret handling

- Build-time secrets: BuildKit secret mounts only.
- Runtime secrets: secret managers / Compose secrets / Swarm secrets.
- Never print secret material in logs, tests, or examples.

## Runtime hardening

- `no-new-privileges` enabled.
- Drop Linux capabilities by default.
- Read-only root filesystem when feasible.
- Restrict network exposure to required ports only.

## Supply-chain controls

- Maintain SBOM for release images.
- Keep base image refresh cadence documented.
- Sign release images if policy requires it.
