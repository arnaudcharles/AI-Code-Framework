# CI.md

Canonical CI specification for this repository. This file is platform-agnostic and is intended to be transformed by an AI into executable pipelines for the target CI provider(s).

## 1) Purpose

Define one portable CI contract that can be rendered into:

- GitHub Actions
- GitLab CI
- Azure DevOps Pipelines
- Jenkins pipeline
- Bitbucket Pipelines
- CircleCI

The rendered pipeline must preserve the same control objectives and pass/fail behavior.

## 2) Inputs required from project

- Project type (service, worker, multi-service stack)
- Runtime language and version
- Docker image name and registry
- Required platforms/architectures (`amd64`, optional `arm64`)
- Deployment target (`compose`, `swarm`, both)
- Security level (`baseline`, `recommended`, `advanced`)
- Release strategy (tagging and promotion rules)

## 3) Global pipeline principles

- Fail closed for security and quality gates.
- Build once, promote by digest.
- Keep jobs deterministic and reproducible.
- No plaintext secrets in repo or logs.
- Artifact traceability from commit -> image digest -> SBOM/attestation.

## 4) Required stages (portable contract)

1. `preflight`
2. `lint`
3. `build`
4. `unit-test`
5. `container-smoke-test`
6. `container-scan`
7. `sbom`
8. `sign-and-attest` (conditional by policy)
9. `publish` (main/tags only)
10. `promotion` (environment-specific, optional)

## 5) Stage specifications

### 5.1 preflight

Goals:
- Validate branch/tag policy
- Validate required CI variables are present
- Validate Docker/Buildx availability

Fail conditions:
- Missing required variables
- Forbidden release action from non-authorized branch/tag

### 5.2 lint

Goals:
- Dockerfile lint with hadolint
- Optional manifest/policy lint for compose/stack files

Fail conditions:
- Any blocker lint finding

### 5.3 build

Goals:
- Build image with BuildKit/Buildx
- Produce immutable image digest
- Export metadata labels

Outputs:
- image digest
- build metadata

Fail conditions:
- Build failure
- Missing digest output

### 5.4 unit-test

Goals:
- Run language-level tests outside container where relevant

Fail conditions:
- Any required test suite fails

### 5.5 container-smoke-test

Goals:
- Start container image
- Validate startup and healthcheck behavior
- Validate expected port/process behavior

Fail conditions:
- Container exits unexpectedly
- Healthcheck fails or times out

### 5.6 container-scan

Goals:
- Scan built image (trivy/grype equivalent)
- Enforce severity thresholds

Fail conditions:
- Critical vulnerabilities
- High vulnerabilities if policy requires
- Scanner execution failure

Exception process:
- Time-boxed risk acceptance with owner and expiry

### 5.7 sbom

Goals:
- Generate SBOM (CycloneDX or SPDX)
- Store SBOM as artifact linked to digest

Fail conditions:
- SBOM generation failure

### 5.8 sign-and-attest

Goals:
- Sign image digest (e.g. cosign)
- Attach provenance attestation

Execution condition:
- Required for `recommended`/`advanced` policy or protected releases

Fail conditions:
- Signing/attestation failure when required

### 5.9 publish

Goals:
- Push immutable tagged image
- Push by digest reference

Execution condition:
- Protected branch/tag only

Fail conditions:
- Publish from unauthorized ref
- Registry auth failure

### 5.10 promotion

Goals:
- Promote existing digest between environments
- Never rebuild for environment promotion

Fail conditions:
- Missing source digest
- Environment policy mismatch

## 6) Mandatory artifacts

- Build logs
- Image digest file
- Test reports
- Vulnerability scan report
- SBOM file
- Attestation metadata (if enabled)

Retention guidance:
- PR builds: short retention
- Main/release builds: longer retention for audit and rollback

## 7) Security and secret rules

- Secrets injected only from CI secret store or external secret manager.
- No secret in pipeline YAML, Dockerfile, or committed env files.
- Redact secret-like values in logs.
- Use short-lived credentials when supported.
- Restrict publish credentials to publish stages only.

## 8) Branch and trigger policy (default)

- Pull request: run preflight/lint/build/tests/scan/sbom.
- Main branch: run all required checks and optional publish to internal registry.
- Release tag: run full release path including sign/attest/publish.
- Manual promotion: digest-only promotion workflow.

## 9) Provider mapping guide

Use this mapping when rendering pipeline files.

- Stage: provider job/stage abstraction
- Artifacts: provider artifact upload/download primitive
- Secrets: provider secret variable store
- Protected refs: provider branch/tag protection mechanism
- Required checks: provider merge gate/status check

The AI generating provider-specific files must preserve semantics, not syntax.

## 10) Policy profiles

### Baseline

- hadolint
- build + smoke test
- vulnerability scan (block critical)
- SBOM generation

### Recommended

Baseline plus:
- block high vulnerabilities (unless approved exception)
- signed images for release tags
- provenance attestation for release builds
- policy check on compose/stack manifests

### Advanced

Recommended plus:
- digest-only deployment policy enforcement
- stricter secret scope and key rotation checks
- provenance verification on promotion
- mandatory change-approval rules for exception use

## 11) AI output contract (when generating executable CI)

When an AI uses this file to generate CI, it must output:

1. Selected provider and rationale
2. Assumptions (explicit)
3. Generated pipeline file(s)
4. Required secret/variable inventory
5. Trigger and branch protection configuration
6. Example local reproduction commands
7. Validation checklist (what must pass)
8. Known limitations and follow-up actions

## 12) Minimal secret and variable inventory template

Required variables (example placeholders):

- `REGISTRY_URL`
- `REGISTRY_REPOSITORY`
- `IMAGE_NAME`
- `IMAGE_TAG_STRATEGY`
- `SCAN_FAIL_THRESHOLD`
- `SBOM_FORMAT`
- `SIGNING_ENABLED`

Required secrets (example placeholders):

- `REGISTRY_USERNAME` or workload identity binding
- `REGISTRY_PASSWORD` or token
- `SIGNING_KEY_REF` (if key-based signing)
- `SIGNING_IDENTITY` (if keyless signing)

## 13) Definition of done for CI

CI is considered complete when:

- All required stages are implemented for the selected profile.
- Pipeline is executable on the target provider.
- Required secrets/variables are documented and validated.
- Release path enforces intended security gates.
- A rollback-capable artifact chain exists (digest + SBOM + reports).
