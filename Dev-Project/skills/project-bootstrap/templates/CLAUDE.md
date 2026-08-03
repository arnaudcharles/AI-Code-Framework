# CLAUDE.md

This repository is configured for Claude-assisted development.

## Purpose
- Build and maintain the project safely and efficiently.
- Keep stable operating rules separate from live project state.
- Support safe context switching across conversations.
- Minimize repetition and token waste.

## Reading order
1. `CLAUDE.md`
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

## Working rules
- Ask only the minimum necessary questions.
- Do not duplicate content across files.
- Keep answers concise and actionable.
- Prefer durable guidance over long chat history.
- Prefer explicit decisions over implicit assumptions.
- Do not invent project details.
- Do not take side effects without approval.
- Tell me `READY` when the base is complete and stable.
- Tell me `NEWCHAT` when the conversation should be restarted.

## Style rules
- Use concise Markdown.
- Use clear headings and short lists.
- Separate facts, assumptions, decisions, and tasks.
- Prefer concrete next actions.
- Avoid unnecessary prose.

## Authorship rule
- Never credit Claude as author, co-author, committer, or pusher.
- Do not add `Co-authored-by: Claude`.
- Do not include Claude in metadata unless explicitly requested.

## Project handoff rule
When the project base is complete, the repository must be usable in a fresh conversation by providing:
- `CLAUDE.md`
- `PROJECT.md`
- `SECURITY.md`
- `CONTRIBUTING.md`
- relevant `/docs`
- relevant `/manuals`