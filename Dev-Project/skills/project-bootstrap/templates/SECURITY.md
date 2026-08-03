# SECURITY.md

## Security goals
- Protect secrets, credentials, tokens, and private data.
- Keep trust boundaries explicit.
- Minimize the blast radius of mistakes.
- Prefer least privilege.
- Make security-sensitive changes obvious and reviewable.

## Non-negotiable rules
- Never commit secrets, API keys, tokens, private certificates, or credentials.
- Never hardcode sensitive values.
- Use environment variables or a secret manager for sensitive configuration.
- Treat `.env` files as sensitive and do not expose them.
- Avoid printing secrets in logs, errors, examples, or docs.
- Sanitize and validate all untrusted input.
- Escape or encode output where needed.
- Review auth, permissions, identity, and data-handling changes carefully.
- Keep dependency upgrades intentional and reviewable.
- Remove unused secrets, tokens, and credentials promptly.

## Secure development expectations
- Follow least privilege for access and permissions.
- Keep authentication flows explicit.
- Keep authorization checks close to the protected action.
- Validate external input at boundaries.
- Prefer well-maintained dependencies.
- Avoid introducing unnecessary attack surface.
- Document any security assumptions that matter to the project.

## Sensitive data handling
- Do not store production secrets in plain text.
- Do not paste private keys or credentials into chat.
- Do not include internal-only URLs or identifiers in public docs.
- Do not copy credentials into commit messages or issue text.
- Redact sensitive values in examples.

## AI usage rule
- Claude may help generate code and documentation, but the resulting repo must follow the project’s security rules exactly.
- If a change affects secrets, auth, permissions, PII, or trust boundaries, call it out explicitly.