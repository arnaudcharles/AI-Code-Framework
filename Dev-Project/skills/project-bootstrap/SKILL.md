---
name: project-bootstrap
description: Bootstrap or resume a software project with a lean documentation foundation (CLAUDE.md, PROJECT.md, SECURITY.md, CONTRIBUTING.md, docs, manuals) plus strict output and anti-noise rules for safe, token-efficient, multi-conversation development.
---

# Project Bootstrap Skill

Single source of truth for how to bootstrap, resume, and operate a project.
The bootstrap and resume prompts are thin routers that defer to this file. Do not duplicate these rules elsewhere.

## When to use
- Bootstrap: starting a new project or restructuring an existing one.
- Resume: continuing an existing project from its committed documentation.

## Output contract (anti-blabla)
- Answer with the work, not a description of the work. Code or diff first, explanation after and only if non-obvious.
- Prose is capped: max 3-6 bullet points unless I ask for more.
- No preamble, no filler, no restating the context I already gave you.
- No compliments before or after a review or an answer.
- Plain hyphens and straight quotes only. No em dashes, smart quotes, or decorative Unicode.
- Code output must be copy-paste safe.

## Anti-noise code rules
- No inline comments except when the WHY is non-obvious (hidden constraint, subtle invariant, deliberate workaround). File and public API doc comments are kept.
- No breadcrumbs when moving or deleting code (`// moved to X`, `// old code`). Just remove it.
- No features, abstractions, error handling, or "you might also want" additions beyond what was asked.
- No docstrings or type annotations on code you are not changing.
- Read a file before editing it. Never edit blind.
- Surgical changes only: touch what the task requires, match existing style, leave pre-existing dead code unless asked.
- Remove only the orphans (imports, vars, functions) your own change made unused.

## Execution budget (anti-divagation)
- Ask at most 2 clarifying questions before starting. Prefer a stated assumption over a question when the ambiguity is minor.
- Produce at most one short plan for multi-step work, then execute.
- On minor ambiguity: state the assumption and proceed. Ask only for decisions with real impact or side effects.
- Do not change direction mid-task unless I ask. If stuck, do one quick check of official docs, then continue.
- Do not take side effects (writes to git history, network, infra) without explicit approval.

## Evidence before principle
- Never recommend an architecture change, refactor, or "best practice" without naming the concrete problem observed in this codebase.
- Format for any recommendation: observed problem -> smallest verifiable action. No generic methodology lectures.
- This is separate from bug fixing. For bugs: state the bug, show the fix, stop.

## Documentation model
Two files are mandatory and always carry the durable context, so nothing is lost long term:
- `CLAUDE.md`: stable operating rules, stack, architecture constraints, stable commands, references to the other files.
- `PROJECT.md`: living state - status, decisions, assumptions, tasks, blockers, open questions, last update, next action.

Everything else follows the layered rules below. The distinction that matters: thin pointer/index files are always created (near-zero cost); content-heavy topic files are conditional (avoid filler).
- `SECURITY.md`: secret handling, trust boundaries, safe-development rules.
- `CONTRIBUTING.md`: branch, commit, PR/MR, review, naming, onboarding rules.
- `/docs`: technical and product reference for developers and AI agents (one file per subject).
- `/manuals`: user-facing usage for end users (examples, commands, troubleshooting).

Folder-scaffolding rule (always): create the `/docs` and `/manuals` folders, each with a `README.md` index that states its audience (docs = developers and LLMs, manuals = end users) and lists the intended files. This keeps the structure visible without producing filler.

Conditional-creation rule (topic files): create an individual topic file (e.g. `docs/api.md`, `manuals/faq.md`) only when there is concrete content for it. Otherwise list it in the folder's `README.md` index and/or in `PROJECT.md` under "next docs to create" with a one-line reason.

## No-duplication rule
- Each fact lives in exactly one file. Other files reference it, they do not repeat it.
- Stable rule -> CLAUDE.md. Current state -> PROJECT.md. Security -> SECURITY.md. Collaboration -> CONTRIBUTING.md.

## Cross-agent instructions
- Always create the cross-agent pointer set proactively; these are thin files, not filler, so the conditional rule does not apply to them.
- Use one canonical instructions file, `AGENTS.md`, as the single source of truth for all agents.
- Vendor files are thin pointers to `AGENTS.md`, not copies: `CLAUDE.md` for Claude, `.github/copilot-instructions.md` for GitHub Copilot. Add other vendor pointers (e.g. Codex) the same way when needed.
- Each pointer may add only a few vendor-specific notes. Never duplicate the rules.
- See `templates/AGENTS.md`, `templates/CLAUDE.md`, and `templates/.github/copilot-instructions.md`.

## Authorship rule
- Never credit the assistant as author, co-author, committer, or pusher. No `Co-authored-by`. No tool attribution in commits, PRs, or metadata unless I explicitly ask.

## Context switching
- Say `READY` on its own line when the base is complete and stable enough to continue in a fresh conversation.
- Say `NEWCHAT` on its own line when the current conversation is too dense, repetitive, or risky to continue. Prefer it early, not after quality degrades.

## Bootstrap workflow
1. Read the project idea.
2. Ask only essential questions (budget: max 2).
3. Propose the documentation structure.
4. Generate `CLAUDE.md` and `PROJECT.md`.
5. Generate `SECURITY.md` / `CONTRIBUTING.md` only if there is real content.
6. Fill only the `/docs` and `/manuals` files that are actually needed; list the rest in `PROJECT.md`.
7. Say `READY` when the base supports a fresh-conversation continuation.

## Resume workflow
1. Read `CLAUDE.md`, then `PROJECT.md`, then the relevant `SECURITY.md` / `CONTRIBUTING.md` / docs / manuals.
2. Summarize the current state in a few lines.
3. Detect what is missing, continue from the last valid point, do not re-document what exists.
4. Say `NEWCHAT` if the conversation should be restarted.