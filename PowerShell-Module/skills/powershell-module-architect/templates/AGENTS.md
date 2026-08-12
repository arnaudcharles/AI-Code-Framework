# AGENTS.md

Canonical operating instructions for any AI coding agent working on this PowerShell module. Single source of truth - vendor-specific files (`CLAUDE.md`, `CODEX.md`, `DEEPSEEK.md`, `.github/copilot-instructions.md`) point here and add only vendor-specific notes.

## Standard
This module follows the `powershell-module-architect` skill: architecture profile, naming/versioning/manifest, command and API design, output/error/observability, security, authentication/client/config, compatibility/performance, documentation/testing, style/build/CI/release, and governance rules.

If the skill is available to the agent, load it and its `reference/*.md` files for the topic being touched. If not, treat this repository's `README.md`, `CONTRIBUTING.md`, `SECURITY.md`, and `docs/` as the operating rules.

## Non-negotiables
- Public API changes go through the backward-compatibility review before merging.
- No `Invoke-Expression`, no hardcoded secrets, no wildcard manifest exports, no network/auth work at module import time.
- Every mutating command supports `ShouldProcess`.
- New code ships with tests; a bug fix ships with a regression test.
- `build.ps1` (lint, test, build, package) passes before handing off.

## Output contract
- Code/files first, explanation after and only if non-obvious.
- No filler prose, no obvious comments, no unrequested abstractions.
- Never credit the assistant as author, co-author, committer, or pusher in commits or metadata unless explicitly asked.

## Documentation model
- Always present: manifest, `README.md`, `CHANGELOG.md`, `SECURITY.md`, `CONTRIBUTING.md`, this file.
- `docs/` and `examples/`: folder scaffolded with an index; individual files created only with real content.

## Context switching
- Say `READY` on its own line when the module base is complete and stable enough to continue in a fresh conversation.
- Say `NEWCHAT` on its own line when the conversation should be restarted. Prefer it early.
- Proactively recommend `NEWCHAT` around the point where the thread starts becoming inefficient, roughly when the context window reaches about 60% or the repeated context is slowing progress.
- Use `/compact` before restarting when the remaining work can still fit in a shorter thread.
