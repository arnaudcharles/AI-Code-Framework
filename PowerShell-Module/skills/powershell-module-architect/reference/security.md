# Security Standard

Apply secure-by-default behavior throughout.

## Input trust
Treat as untrusted: command parameters, pipeline input, environment variables, config files, API responses, local files, registry values, process output, plugin/provider output, serialized data, remote-downloaded metadata. Validate at the boundary; normalize before authorization-sensitive comparison. Never rely on UI or documentation to enforce constraints.

## Code execution
Never use `Invoke-Expression`. Never build executable PowerShell from untrusted strings. Avoid `ScriptBlock.Create` for user-controlled content. If script blocks are a deliberate extension mechanism: type as `[scriptblock]`, document trust implications, invoke with controlled arguments, never silently elevate privileges, never deserialize remote script content into execution.

## Secrets
Never hardcode or commit: credentials, API keys, private-key certificates, bearer tokens, real connection strings, sensitive production tenant IDs, decrypted secret fixtures. Use approved secret stores or injected credentials. Support SecretManagement where it adds real value; do not force it when native identity mechanisms are superior. Secrets must never appear in logs, verbose/debug output, errors, transcripts, examples, test snapshots, CI output, process arguments (when avoidable), or temp filenames. Clear sensitive buffers where practical, acknowledging managed-memory limits.

## Network security
HTTPS only, validate TLS certificates. Never expose a casual `-SkipCertificateCheck` in production; an exceptional dev-only bypass must be isolated, explicit, strongly warned, off by default, and tested as such. Set timeouts, bound retries, use exponential backoff with jitter for transient failures, honor `Retry-After`. Never retry auth failures, authorization failures, deterministic validation errors, or destructive non-idempotent operations without idempotency protection. Restrict redirects when credentials/auth headers could cross trust boundaries. Validate download integrity (hashes/signatures) for executable or package content.

## File security
Use safe temp-file APIs with random, non-predictable names and restrictive permissions where supported. Avoid writing secrets to disk. Use atomic replacement for important files. Validate destination paths; guard against path and archive-extraction traversal. Never overwrite existing files without documented semantics and `ShouldProcess`. Clean up temp files in `finally`, tolerating cleanup failure safely.

## Serialization
Prefer JSON, validated config data, strongly typed serializers; use CLIXML only with understood trust implications. Never deserialize untrusted binary object graphs. Never assume imported CLIXML credentials are portable/secure across identities and platforms. Validate schema and size before processing large documents; set a reasonable JSON conversion depth.

## Privilege
Never require admin/root for read-only or user-scoped operations. Detect required privilege before mutation and explain it. Never auto-elevate silently. Separate privileged from unprivileged operations where possible.

## Supply chain
Pin or deliberately constrain build dependencies; verify downloaded build tools; use dependency review and vulnerability scanning. Publish from protected CI, not an unreviewed workstation, when the delivery model permits it. Prefer short-lived credentials or trusted publishing mechanisms. Protect release environments with approval rules. Generate an SBOM for binary or dependency-heavy modules when appropriate.

## Threat modeling (security-relevant modules)
Document: assets, trust boundaries, entry points, attacker-controlled inputs, privileges, secret lifetime, network destinations, persistence locations, expected abuse cases, mitigations, residual risks. Feed this into the Security review section of the Final response format (see `SKILL.md`).
