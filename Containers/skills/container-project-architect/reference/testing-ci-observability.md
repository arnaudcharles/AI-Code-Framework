# Testing, CI, and Observability

## Minimum CI gates

1. Dockerfile lint (hadolint)
2. Build validation (docker buildx)
3. Vulnerability scan (for example trivy or grype)
4. Container smoke tests (startup + health endpoint)
5. Optional policy checks (OPA/conftest) for deployment files

## Test strategy

- Unit tests for application logic (outside container).
- Container-level smoke tests for startup/runtime contract.
- Integration tests for service-to-service behavior in Compose.
- Regression tests for every production bug fix.

## Observability baseline

- Structured logs with request correlation fields.
- Health and readiness endpoints.
- Metrics endpoint or exporter for key service signals.
- Explicit redaction for secrets and personal data.

## CI execution rules

- Use reproducible build context and deterministic tags.
- Prefer build cache to reduce cycle time.
- Publish scan reports as CI artifacts.
- Prevent unsigned/unscanned images from release path.

## Quality signal thresholds

- Lint: zero blocker findings.
- Scan: no critical vulnerabilities without approved exception.
- Tests: all required suites pass on default branch.
