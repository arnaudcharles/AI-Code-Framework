# CI And Delivery

## Purpose

Keep CI policy provider-agnostic while enabling deterministic, enforceable release gates.

## Required stages

1. preflight
2. lint
3. test
4. package
5. validate
6. publish (release events only)

## Required checks

- metadata-json-lint
- puppet-lint
- rspec-puppet
- optional acceptance matrix for supported OS targets
- security checks defined in SECURITY.md

## Release safety

- Publish only from protected branch/tag strategy.
- Block publish when required secrets are missing.
- Block publish if tests or security checks fail.
- Require manual approval for production publication when risk level is high.

## Artifact expectations

- test reports
- lint reports
- package artifact
- release notes/changelog linkage
