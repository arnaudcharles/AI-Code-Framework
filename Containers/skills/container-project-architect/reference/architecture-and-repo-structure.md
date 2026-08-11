# Architecture and Repository Structure

## Profiles

Select exactly one profile for a project. Do not mix profiles by default.

- Profile A - Single service with Dockerfile + Compose
- Profile B - Multi-service Compose stack (app + dependencies)
- Profile C - Swarm-ready service with deploy controls
- Profile D - Platform baseline repo (shared CI, policies, templates)

## Selection guidance

Choose the smallest profile that satisfies:
- Runtime reliability requirements
- Secret handling requirements
- Deployment and rollback requirements
- Team operational maturity

Escalate profile only when concrete constraints require it.

## Required repository baseline

- `AGENTS.md` (canonical instructions)
- `PROJECT.md` (live state)
- `container.md` (container standards and guardrails)
- `README.md`
- `SECURITY.md`
- `CONTRIBUTING.md`
- `.dockerignore`
- `Dockerfile`
- `compose.yaml` (or `stack.yaml` for Swarm)
- `.github/workflows/ci.yml`
- `docs/README.md`
- `manuals/README.md`

## Compatibility boundaries

Treat these as contracts unless a breaking change is approved:
- Image repository/name and tag semantics
- Required env vars and defaults
- Exposed ports and protocols
- Volume paths and persistence contracts
- Service names in Compose/Swarm
- Healthcheck behavior

## Change policy

- Non-breaking: internal layer optimization, lint improvements, test additions.
- Potentially breaking: base image switch, port changes, env var removals, user/permission changes, startup command changes.
- Breaking changes require explicit note and migration instructions.
