# PROJECT.md

Live project state and decision log.

## Snapshot

- Name: <module-name>
- Scope: <what the module manages>
- Supported Puppet: <version range>
- Supported OS: <targets>
- Current phase: bootstrap

## Current state

- Architecture summary: <current architecture>
- Test coverage posture: <current status>
- Security posture summary: <current status>

## Risks and technical debt

- Risk: <description>
	- Impact: <impact>
	- Mitigation: <mitigation>

## Decisions

- Date: <yyyy-mm-dd>
- Decision: <summary>
- Reason: <why>
- Impact: <trade-off>

## Work queue

- [ ] Define module interfaces (classes and defined types)
- [ ] Finalize Hiera data contracts
- [ ] Implement manifests/templates/files
- [ ] Add tests and CI checks
- [ ] Prepare release package

## Findings

Use this structure for all findings.

| severity | area | file | impact | fix | effort | priority |
|---|---|---|---|---|---|---|
| medium | test | spec/classes/init_spec.rb | missing negative test path can hide regression | add invalid-parameter compile-failure test | s | p2 |

Allowed values:
- severity: critical, high, medium, low
- area: manifest, data, template, test, ci, dependency, docs, process
- effort: s, m, l
- priority: p0, p1, p2, p3

## Quick wins

- [ ] <small high-value improvement>
- [ ] <small high-value improvement>

## Recommended plan

1. Stabilize baseline security and input validation.
2. Close p0/p1 findings with tests and CI gates.
3. Improve documentation coverage for manifests and Hiera contracts.
4. Prepare release controls and changelog discipline.

## Context management

- Mark READY when baseline is stable.
- Recommend /compact before restart when useful.
- Trigger NEWCHAT around 60 percent context or when the thread becomes inefficient.
