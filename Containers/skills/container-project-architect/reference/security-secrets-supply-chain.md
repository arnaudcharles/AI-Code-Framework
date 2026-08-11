# Security, Secrets, and Supply Chain

## Threat model baseline

Protect against:
- Secret exposure in image layers, env vars, logs, or CI output
- Compromised dependencies/base images
- Privilege escalation inside containers
- Unauthorized image tampering in registry or transit

## Secret handling rules

- No secrets in source, Dockerfile, or committed env files.
- Use runtime secret providers (Compose/Swarm/KMS/Vault).
- Build-time secrets must use ephemeral secret mounts.
- Redact secret-like values in logs and test output.

## Image trust and integrity

- Pull trusted, maintained base images.
- Scan base and final images in CI.
- Generate SBOM (CycloneDX or SPDX).
- Sign release images (for example with cosign) when policy requires it.
- Store attestations/provenance with released artifacts.

## Vulnerability management

- Fail CI on critical vulnerabilities unless formally risk-accepted.
- Track accepted exceptions with expiry date and owner.
- Rebuild images on base-image security updates.

## Runtime hardening

- Non-root user.
- Read-only root filesystem when possible.
- Drop all capabilities and add only required ones.
- `no-new-privileges` enabled.
- Minimize network exposure by default.

## Registry and access control

- Use short-lived CI credentials.
- Scope push permission to release workflows only.
- Enforce immutable tags for released images where possible.
