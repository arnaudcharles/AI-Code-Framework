# Documentation Map

This repository uses a documentation structure designed for clarity, maintainability, and safe context switching.

## AGENTS.md
Canonical operating instructions for every AI agent. Single source of truth.

## CLAUDE.md / .github/copilot-instructions.md
Thin, vendor-specific pointers to `AGENTS.md`. They add only agent-specific notes, never duplicate the rules.

## PROJECT.md
Living project state: current status, decisions, tasks, blockers, and next steps.

## SECURITY.md
Security rules, secret-handling rules, trust boundaries, and safe development expectations.

## CONTRIBUTING.md
Contribution workflow, branch naming, commit format, review expectations, and onboarding guidance.

## /docs
Technical and product reference documentation.

## /manuals
User-facing usage docs, examples, commands, troubleshooting, and FAQs.

## CI files

When the project needs a CI contract, use:
- `CI.md` for the provider-agnostic pipeline specification
- `Generate-CI.md` for turning `CI.md` into an executable provider-specific pipeline