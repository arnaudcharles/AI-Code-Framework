# Container Project Template

Production-oriented baseline for container projects with Dockerfile, Compose, CI gates, and explicit security/operations standards.

## What this template includes

- Opinionated container standards in `container.md`.
- Multi-stage Dockerfile template with non-root runtime.
- Compose baseline with healthchecks and hardened runtime options.
- CI workflow with lint, build, scan, and smoke-test stages.
- Documentation pointers for cross-agent continuity.

## Quick start

1. Replace image names, ports, and commands for your service.
2. Replace placeholder digests and secret names.
3. Run lint/build/test locally.
4. Enable CI secrets and registry settings.

## Contracts to keep stable

- Service names and ports
- Required env vars
- Volume mount paths
- Healthcheck endpoint and behavior

## Documentation map

- `AGENTS.md` for agent operating rules
- `PROJECT.md` for live status
- `container.md` for container standards
- `CI.md` for platform-agnostic CI specification
- `Generate-CI.md` for turning `CI.md` into executable provider-specific pipelines
- `SECURITY.md` for security constraints
