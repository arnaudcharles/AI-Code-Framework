# AGENTS.md

Canonical operating instructions for any AI coding agent in this repository.
This is the single source of truth. Agent-specific files (`CLAUDE.md`, `.github/copilot-instructions.md`, etc.) point here and add only vendor-specific notes.

## Purpose
- Build and maintain the project safely and efficiently.
- Keep stable operating rules separate from live project state.
- Support safe context switching across conversations.
- Minimize repetition and token waste.

## Reading order
1. `AGENTS.md` (this file)
2. `PROJECT.md`
3. `SECURITY.md`
4. `CONTRIBUTING.md`
5. Relevant files in `/docs`
6. Relevant files in `/manuals`

## File responsibilities
- `PROJECT.md`: live project state, decisions, tasks, blockers, next step.
- `SECURITY.md`: secret handling, trust boundaries, safe development rules.
- `CONTRIBUTING.md`: branch, commit, PR/MR, review, naming, and onboarding rules.
- `/docs`: technical and product reference documentation.
- `/manuals`: user-facing usage docs, examples, commands, troubleshooting.

## Output contract
- Answer with the work, not a description of it. Code or diff first, explanation after and only if non-obvious.
- Prose capped at 3-6 bullets unless asked for more. No preamble, no filler, no restating given context.
- No compliments before or after a review.
- Plain hyphens and straight quotes only. Code output must be copy-paste safe.

## Anti-noise code rules
- No inline comments unless the WHY is non-obvious. Keep file and public-API doc comments.
- No breadcrumbs when moving or deleting code. Just remove it.
- No features, abstractions, error handling, or speculative additions beyond what was asked.
- No docstrings or type annotations on code you are not changing.
- Read a file before editing it. Surgical changes only; match existing style.

## Execution rules
- Ask at most 2 clarifying questions. Prefer a stated assumption over a question on minor ambiguity.
- One short plan for multi-step work, then execute. Do not change direction mid-task unless asked.
- No side effects (git history, network, infra) without explicit approval.

## Evidence before principle
- No architecture/refactor/best-practice recommendation without naming the concrete problem observed here.
- Recommendation format: observed problem -> smallest verifiable action.
- For bugs: state the bug, show the fix, stop.

## Documentation model
- `AGENTS.md` and `PROJECT.md` are mandatory and hold the durable context.
- Everything else is created only when it has real content. Do not scaffold empty files.
- If a file is not created yet, list it in `PROJECT.md` under "next docs to create" with a one-line reason.
- Each fact lives in exactly one file; other files reference it.

## Authorship rule
- Never credit the assistant as author, co-author, committer, or pusher. No `Co-authored-by`. No tool attribution in commits or metadata unless explicitly requested.

## Context switching
- Say `READY` on its own line when the base is complete and stable enough to continue in a fresh conversation.
- Say `NEWCHAT` on its own line when the conversation should be restarted. Prefer it early.
