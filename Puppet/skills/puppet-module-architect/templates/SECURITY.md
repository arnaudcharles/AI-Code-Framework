# SECURITY.md

Security baseline for this Puppet module.

## Scope

Defines controls and verification methods. This file does not assert automatic compliance.

## Applicable control families

- OWASP secure design and input validation practices
- PCI DSS change control and least-privilege aligned controls
- Microsoft security guidance (least privilege, supply-chain hygiene, secure defaults)

## Required controls

| control | objective | implementation | verification |
|---|---|---|---|
| input validation | reject unsafe values | typed params with strict constraints | rspec negative tests |
| secure defaults | avoid insecure initial state | hardened class defaults | catalog tests |
| secret hygiene | prevent leakage | secret backend integration, no plaintext secrets | repository and CI secret scans |
| least privilege | limit elevated actions | minimal privileged resources | code review checklist |
| supply chain | reduce dependency risk | explicit dependencies and review | dependency diff review |

## Vulnerability handling

- Report privately through maintainer channel.
- Classify severity and operational impact.
- Track fix in PROJECT.md findings table.
- Require post-fix regression tests.
