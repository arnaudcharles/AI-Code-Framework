# AGENTS.md

Canonical operating instructions for any AI coding agent in this container project. This is the single source of truth. Vendor-specific files (`CLAUDE.md`, `CODEX.md`, `DEEPSEEK.md`, `.github/copilot-instructions.md`) point here.

## Reading order

1. `AGENTS.md`
2. `PROJECT.md`
3. `container.md`
4. `SECURITY.md`
5. `CONTRIBUTING.md`
6. `README.md`
7. Relevant files in `docs/` and `manuals/`

## Non-negotiables

- No `latest` tags in Dockerfiles or deployment manifests.
- Multi-stage builds for production images.
- Runtime container must run as non-root unless a documented exception exists.
- No secrets in Dockerfile, image layers, or committed env files.
- CI must run lint + build + scan + smoke tests before merge.
- Breaking container contract changes must be explicitly documented.

## Documentation model

- `PROJECT.md` is the live project state.
- `container.md` is the authoritative container standards guide for this repo.
- `docs/` is technical/internal reference.
- `manuals/` is end-user/operator usage.

## Context switching

- Say `READY` on its own line when the base is complete and stable enough to continue in a fresh conversation.
- Say `NEWCHAT` on its own line when the conversation should be restarted. Prefer it early.
- Proactively recommend `NEWCHAT` around the point where the thread starts becoming inefficient, roughly when the context window reaches about 60% or the repeated context is slowing progress.
- Use `/compact` before restarting when the remaining work can still fit in a shorter thread.

## Authorship rule

Never credit the assistant as author, co-author, committer, or pusher unless explicitly requested.
