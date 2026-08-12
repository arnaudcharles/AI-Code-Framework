# Security And DevSecOps Controls

## Principle

This standard defines applicable and verifiable controls. It does not claim automatic compliance.

## Control model

Each control must include:
- objective
- implementation location
- verification method
- evidence artifact

## Control set

| Control ID | Source | Objective | Puppet implementation | Verification |
|---|---|---|---|---|
| SEC-01 | OWASP (input validation) | Prevent unsafe input propagation | Typed params, constrained patterns/enums | rspec tests for invalid inputs fail |
| SEC-02 | OWASP (secure defaults) | Enforce safe baseline config | Class defaults set hardened values | catalog test validates hardened defaults |
| SEC-03 | OWASP (secrets management) | Prevent secret disclosure | Secret backend integration, no plaintext secrets | repo scan for secret patterns and data review |
| SEC-04 | PCI DSS (access control) | Restrict privileged configuration changes | Explicit ownership/mode and limited write paths | unit tests for file owner/mode and peer review |
| SEC-05 | PCI DSS (change control) | Controlled releases and traceability | versioned releases and changelog entries | CI gate checks version/changelog alignment |
| SEC-06 | Microsoft security guidance (least privilege) | Reduce privilege usage | no unnecessary privileged exec resources | lint and review checklist |
| SEC-07 | Microsoft security guidance (supply chain) | Reduce dependency risk | pinned dependencies and update review | dependency diff review in PR template |
| SEC-08 | DevSecOps | Shift-left security checks | security scans in CI before merge | CI artifacts with pass/fail evidence |

## Evidence checklist

- CI logs for lint, tests, and security checks
- test output proving typed parameter enforcement
- metadata dependency review notes
- release notes capturing security-impacting changes

## Residual risk policy

- Document accepted residual risks in PROJECT.md.
- Assign owner and remediation target date.
- Reassess accepted risks at each minor release.
