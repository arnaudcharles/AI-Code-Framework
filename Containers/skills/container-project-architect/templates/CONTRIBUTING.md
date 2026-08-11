# CONTRIBUTING.md

## Workflow

- Open an issue or task before major changes.
- Keep pull requests small and reviewable.
- Every bug fix includes a regression test.
- Container contract changes require migration notes.

## Branch and commit

- Branch naming: `feat/*`, `fix/*`, `chore/*`, `docs/*`.
- Use clear commit messages with scope.
- Do not bundle unrelated changes in one commit.

## Required checks before merge

- Dockerfile lint passes (hadolint).
- Image build passes.
- Vulnerability scan passes policy threshold.
- Smoke tests pass.
- Documentation updated when contract changed.

## Review focus

- Security impact (secrets, privileges, trust boundaries).
- Runtime compatibility impact (env vars, ports, volumes, healthchecks).
- Operational impact (deployment, rollback, observability).
