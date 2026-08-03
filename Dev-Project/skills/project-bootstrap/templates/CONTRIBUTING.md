# CONTRIBUTING.md

## Purpose
This document explains how contributors should work in this repository.

## Contribution principles
- Keep changes small and focused.
- Update docs when behavior changes.
- Add or update tests when needed.
- Follow the existing style and naming conventions.
- Avoid unrelated refactors in the same change.

## Branch naming
Use descriptive branch names such as:
- `feat/<short-description>`
- `fix/<short-description>`
- `chore/<short-description>`
- `docs/<short-description>`

## Commit messages
Use clear, short, and conventional commit messages such as:
- `feat: add project bootstrap skill`
- `fix: correct security guidance`
- `docs: update onboarding manual`

## Pull request / merge request expectations
- Explain what changed and why.
- List any tradeoffs or limitations.
- Mention tests performed.
- Mention docs updated.
- Mention security impact if relevant.

## Naming conventions
- Use consistent names for files, folders, functions, and variables.
- Prefer descriptive names over clever names.
- Keep abbreviations minimal unless widely understood.

## Review expectations
- Review for correctness, clarity, security, and maintainability.
- Reject changes that introduce unnecessary complexity.
- Verify documentation stays in sync with behavior.

## Onboarding guidance
A new contributor should read:
- `CLAUDE.md`
- `PROJECT.md`
- `SECURITY.md`
- `CONTRIBUTING.md`
- relevant files in `/docs`
- relevant files in `/manuals`

## Claude authorship rule
- Do not credit Claude as author, co-author, committer, or pusher.
- Do not add `Co-authored-by: Claude`.
- Claude is a tool, not an author.

## When to update this file
Update this file when:
- the workflow changes,
- the naming convention changes,
- the review process changes,
- the testing expectations change,
- the collaboration model changes.