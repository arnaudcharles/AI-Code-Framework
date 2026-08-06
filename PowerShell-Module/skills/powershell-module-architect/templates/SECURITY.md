# Security Policy

## Reporting a vulnerability
Describe here how to report a security issue privately (e.g. a security contact email or a private advisory link). Do not open a public issue for a suspected vulnerability.

## Secret handling
- Never commit credentials, API keys, certificates with private keys, or connection strings.
- Secrets never appear in logs, verbose/debug output, error messages, or test fixtures.
- Use `[PSCredential]` or a secret store integration; never accept plaintext password parameters.

## Trust boundaries
Document this module's trust boundaries here once the real design exists: what is treated as untrusted input, what privileges commands require, and what network destinations are contacted.

## Safe development practices
- No `Invoke-Expression`, no dynamic code execution of untrusted content.
- TLS certificate validation is never bypassed by default.
- Dependencies are reviewed and scanned for known vulnerabilities before release.

## Supported versions
State which module versions receive security fixes once a release history exists.
