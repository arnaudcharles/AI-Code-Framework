# Swarm and Orchestration Guidance

## Swarm fundamentals

- Deploy with versioned stack files.
- Use overlay networks with clear segmentation.
- Separate internal and edge-exposed services.

## Service deploy policy

Set explicit deploy controls:
- `replicas`
- `update_config` (parallelism, delay, order)
- `rollback_config`
- `restart_policy`
- `placement` constraints and preferences

## Secrets and configs

- Use Swarm `secrets` and `configs` instead of baked config.
- Rotate secrets with controlled rollout.
- Scope access to services that need them only.

## Zero-downtime strategy

- Prefer rolling updates with health-aware readiness.
- Use start-first update order when app supports parallel startup.
- Define rollback behavior before production rollout.

## Node and scheduling hygiene

- Label nodes for workload classes (edge, stateful, compute).
- Avoid hardcoding host assumptions.
- Keep stateful services pinned and documented.

## Observability and failure handling

- Ensure container logs are structured and centralizable.
- Define alert thresholds for restart loops and unhealthy replicas.
