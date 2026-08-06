# Contributing

## Workflow
1. Branch from `main`: `feature/<short-description>` or `fix/<short-description>`.
2. Make focused commits with clear messages.
3. Run `./build.ps1 -Task All` before opening a pull request.
4. Open a PR against `main`. Public API, security-sensitive, release-pipeline, dependency, and generated-metadata changes require review.

## Coding standards
Follow the `powershell-module-architect` skill (naming, manifest, command design, security, testing). See `AGENTS.md`.

## Testing
- Add or update Pester tests for any behavior change.
- Every bug fix includes a regression test.
- `./build.ps1 -Task Test` must pass.

## Public API changes
Run the backward-compatibility review before changing a public command's name, parameters, output shape, or error IDs. Breaking changes require a major version bump and a documented migration path.

## Commit and versioning
Use clear, conventional commit messages where practical. Version bumps follow SemVer: see the naming/versioning standard.
