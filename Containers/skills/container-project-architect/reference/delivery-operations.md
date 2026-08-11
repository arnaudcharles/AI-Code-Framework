# Delivery and Operations

## Tagging and release policy

- Use immutable release tags (for example `1.4.2`).
- Optional moving tags (`1.4`, `1`, `stable`) may exist but must point to immutable digests.
- Keep branch-based pre-release tags isolated from production promotion.

## Promotion model

- Build once, promote by digest across environments.
- Do not rebuild the same semantic version per environment.
- Keep provenance and SBOM associated with the promoted digest.

## Rollback model

- Predefine rollback target and trigger criteria.
- Keep previous known-good digest available.
- Automate rollback for failed health criteria when feasible.

## Operational readiness checklist

- Document startup/shutdown behavior.
- Document required secrets and external dependencies.
- Document recovery actions for common failure modes.
- Document resource expectations and scaling limits.

## Maintenance routine

- Regular base image refresh cadence.
- Scheduled dependency and vulnerability review.
- Periodic disaster/rollback drills for critical services.
