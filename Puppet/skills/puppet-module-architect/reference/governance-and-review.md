# Governance And Review

## Contribution baseline

- Small, reviewable pull requests.
- Clear change intent and rollback strategy.
- Security-impacting changes require explicit control validation notes.

## Review focus order

1. behavioral regressions
2. security risk
3. compatibility break risk
4. operability and observability
5. style and readability

## Findings taxonomy

Use this schema in PROJECT.md findings logs:
- severity: critical, high, medium, low
- area: manifest, data, template, test, ci, dependency, docs, process
- file: exact path
- impact: operational or security consequence
- fix: concrete remediation
- effort: s, m, l
- priority: p0, p1, p2, p3

## Merge gates

- No unreviewed critical/high findings.
- Documented decision for any accepted medium finding.
- Mandatory tests updated for changed behavior.
- Release notes updated for externally visible changes.
