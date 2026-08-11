# container.md

Canonical best-practices guide for this repository's container architecture. Any exception must be documented with rationale, owner, and expiry date.

## Scope and intent

This document reflects practices seen in mature open-source projects and corporate platform teams. Rules are split by maturity level:

- Baseline: must-have for any serious project.
- Recommended: expected in professional teams.
- Advanced: high-assurance or regulated environments.

## 1) Image source, versions, and immutability

- Baseline: never use `latest` in Dockerfile, Compose, or Swarm manifests.
- Baseline: pin base image versions explicitly (major.minor.patch).
- Recommended: pin runtime images by digest in production (`image:tag@sha256:...`).
- Recommended: use immutable release tags for built images.
- Advanced: enforce digest-only deployments via policy checks.

## 2) Dockerfile architecture and build quality

- Baseline: use multi-stage builds to separate build/test from runtime.
- Baseline: keep runtime image free of compilers and build toolchains.
- Baseline: run as non-root user.
- Recommended: use `COPY --chown` to avoid runtime permission mutation.
- Recommended: deterministic build order and dependency pinning.
- Advanced: use hermetic or near-hermetic builds for reproducibility.

## 3) Dockerfile security controls

- Baseline: do not store secrets in `ARG` or `ENV`.
- Baseline: use BuildKit secret mounts for build-time credentials.
- Baseline: remove package-manager caches and temp files in same layer.
- Recommended: minimize packages and binaries in runtime image.
- Recommended: prefer distroless or slim bases when operationally compatible.
- Advanced: drop shell from runtime image where troubleshooting model allows it.

## 4) Build context and `.dockerignore` hygiene

- Baseline: exclude VCS metadata, caches, local artifacts, credentials, `.env*`.
- Baseline: keep build context minimal to reduce leakage and build time.
- Recommended: exclude test fixtures not needed by runtime image.
- Advanced: validate context size thresholds in CI.

## 5) Runtime hardening defaults

- Baseline: run as non-root by default.
- Baseline: enable `no-new-privileges`.
- Recommended: use read-only root filesystem when app allows it.
- Recommended: drop all Linux capabilities and add back only required ones.
- Recommended: use `tmpfs` for writable temp paths.
- Advanced: apply seccomp/AppArmor profiles and document exceptions.

## 6) Resource and isolation controls

- Baseline: define CPU and memory limits/requests where runtime supports them.
- Recommended: define open-file and process limits for noisy workloads.
- Recommended: separate trust zones with dedicated networks.
- Advanced: enforce egress restrictions and explicit allow-lists.

## 7) Health, readiness, startup, and shutdown

- Baseline: define healthchecks for long-running services.
- Baseline: implement graceful shutdown and signal handling.
- Recommended: expose separate readiness and liveness semantics where possible.
- Recommended: document startup dependencies and warm-up behavior.
- Advanced: verify graceful shutdown timings in automated tests.

## 8) Secrets and configuration strategy

- Baseline: build-time secrets via ephemeral BuildKit mounts only.
- Baseline: runtime secrets via secret manager, Compose secrets, or Swarm secrets.
- Baseline: never log secret values.
- Recommended: rotate secrets with tested runbook and ownership.
- Recommended: separate non-sensitive config from secret material.
- Advanced: short-lived credentials and automatic rotation where feasible.

## 9) Compose best practices

- Baseline: explicit service names and named volumes.
- Baseline: documented env var contracts (`required`, `optional`, default).
- Recommended: profiles for optional services (debug, metrics, tooling).
- Recommended: security options (`user`, `read_only`, `cap_drop`, `no-new-privileges`).
- Advanced: policy checks on compose files before merge.

## 10) Swarm best practices

- Baseline: use `deploy` with explicit `replicas`, `update_config`, `rollback_config`, `restart_policy`.
- Baseline: use Swarm secrets/configs for sensitive/runtime config.
- Recommended: placement constraints and node labels with clear intent.
- Recommended: define zero-downtime and rollback strategy before production rollout.
- Advanced: canary or staged rollouts with measured promotion criteria.

## 11) CI gates and quality enforcement

- Baseline: hadolint on Dockerfile(s).
- Baseline: build validation on every PR.
- Baseline: vulnerability scan (for example trivy or grype).
- Baseline: smoke test in container runtime.
- Recommended: integration tests for multi-service behavior.
- Recommended: fail release on critical findings unless approved exception exists.
- Advanced: policy-as-code checks (for example conftest/OPA) for Docker/Compose/Swarm manifests.

## 12) Supply chain, SBOM, signing, provenance

- Baseline: generate SBOM for release images.
- Recommended: sign release images (for example cosign).
- Recommended: store provenance and attestations linked to image digest.
- Recommended: rebuild on base-image CVE fixes.
- Advanced: SLSA-oriented provenance and verifiable build pipelines.

## 13) Vulnerability management policy

- Baseline: block critical vulnerabilities in release path.
- Recommended: define SLA by severity (critical/high/medium).
- Recommended: time-boxed risk acceptance with owner and expiry.
- Recommended: dependency and base-image refresh cadence.
- Advanced: automated CVE triage and drift dashboards.

## 14) Testing strategy

- Baseline: unit tests for business logic.
- Baseline: container smoke tests for startup and health endpoint.
- Recommended: integration tests for service contracts.
- Recommended: regression tests for every production bug fix.
- Advanced: chaos/failure-injection tests for critical systems.

## 15) Observability and incident readiness

- Baseline: structured logs with correlation metadata.
- Baseline: redact secrets and sensitive values in logs/errors.
- Recommended: metrics for latency, errors, saturation, restarts, OOM kills.
- Recommended: alerting for unhealthy status and restart loops.
- Advanced: traces for cross-service latency and dependency bottlenecks.

## 16) Delivery, release, and rollback model

- Baseline: build once, promote by digest.
- Baseline: keep previous known-good digest available.
- Recommended: explicit rollback triggers and execution steps.
- Recommended: migration notes for breaking runtime contract changes.
- Advanced: progressive delivery (canary/blue-green) with automated rollback conditions.

## 17) Compatibility contract management

Treat these as compatibility contracts unless explicitly broken:

- image naming and tag semantics
- required env vars and defaults
- exposed ports and protocols
- volume paths and persistence behavior
- service names in Compose/Swarm
- healthcheck behavior and timing

Breaking changes require:

- migration guide
- rollback plan
- versioning note

## 18) Governance and exceptions

- Baseline: every exception includes rationale, owner, expiry date, and mitigation.
- Recommended: security/platform review for privileged flags, root runtime, or disabled scans.
- Recommended: regular exception review and cleanup.
- Advanced: exception debt tracked as first-class backlog.

## 19) Open-source vs corporate reality check

Common in mature open source:

- pinned tags, multi-stage builds, non-root runtime
- hadolint plus basic vulnerability scanning
- release tags and changelog discipline

Common in corporate/pro platform teams:

- digest-only deploys in production
- signed images, SBOM, provenance attestations
- policy-as-code enforcement in CI
- vulnerability SLA with formal risk acceptance workflow
- standardized rollback runbooks and incident KPIs

Target recommendation for this repository:

- implement all Baseline items immediately
- schedule Recommended items as near-term hardening
- adopt Advanced controls based on risk, compliance, and team maturity
