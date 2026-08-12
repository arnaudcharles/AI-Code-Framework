# Testing, Lint, And Quality Gates

## Required test layers

- Static: puppet parser validate, metadata-json-lint, puppet-lint.
- Unit: rspec-puppet for class and defined type behavior.
- Optional acceptance: litmus or equivalent for realistic apply runs.

## Unit test expectations

- Compile with all dependencies.
- Validate default and non-default parameter paths.
- Validate resource attributes and relationships for critical resources.
- Cover key failure paths for invalid input.

## Lint and style

- Enforce style with puppet-lint and RuboCop where Ruby helpers are used.
- Keep a strict baseline and document exceptions.

## Quality gates before merge

- No failing tests.
- No unresolved high-severity findings.
- Release notes and changelog aligned with changes.
- Security-relevant changes include explicit control verification evidence.
