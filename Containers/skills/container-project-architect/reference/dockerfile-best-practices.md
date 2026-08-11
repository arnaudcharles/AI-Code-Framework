# Dockerfile Best Practices

## Base image and pinning

- Use a trusted base image with explicit version tags.
- Prefer digest pinning (`image:tag@sha256:...`) for high-trust environments.
- Avoid `latest` and floating major tags.
- Keep runtime image minimal (distroless/alpine/slim when compatible).

## Multi-stage build

- Separate build/test dependencies from runtime image.
- Copy only required runtime artifacts into final stage.
- Keep final stage free of package managers and build toolchains when possible.

## Non-root and least privilege

- Create and use a dedicated non-root user.
- Use `COPY --chown` to avoid runtime ownership fixes.
- Avoid privileged entrypoints and broad Linux capabilities.

## Layer and cache hygiene

- Keep dependency restore steps isolated for cache reuse.
- Combine package install and cleanup in one layer.
- Use BuildKit cache mounts for package managers when supported.
- Sort package lists and keep deterministic install order.

## Secrets during build

- Never pass secrets via plain `ARG`/`ENV`.
- Use BuildKit secrets (`RUN --mount=type=secret,...`) for temporary access.
- Ensure secret material is not copied into final layers.

## Reproducibility and metadata

- Pin dependency versions where feasible.
- Set OCI labels (`org.opencontainers.image.*`).
- Prefer immutable image references in deployment manifests.

## Dockerfile quality gate

- Enforce hadolint in CI.
- Block merge when lint violations exceed policy threshold.
