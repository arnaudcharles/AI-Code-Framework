# AGENTS.md

Canonical operating instructions for any AI coding agent in this Puppet repository.

## Reading order

1. AGENTS.md
2. PROJECT.md
3. SECURITY.md
4. CONTRIBUTING.md
5. README.md
6. docs/README.md
7. manuals/README.md

## Non-negotiables

- No secrets committed in code, templates, or data files.
- Typed Puppet parameters and explicit validation for untrusted inputs.
- Idempotent manifests only.
- CI must run lint + tests + validation before merge.
- No breaking interface changes without a major version plan.

## Comment verbosity controls

- COMMENT_LEVEL=1 (default): strict minimum comments.
- COMMENT_LEVEL=2: additional comments for non-obvious code paths.
- COMMENT_LEVEL=3: detailed, noob-friendly explanations.
- MORE_VERBOSE_COMMENTS=true forces at least COMMENT_LEVEL=2 behavior.

## Context lifecycle

- Say READY on its own line when the project base is stable.
- Propose /compact before restart if a short context compaction can preserve progress.
- Propose NEWCHAT automatically when context approaches about 60 percent or thread efficiency degrades.

## Authorship

Do not list the assistant as author, co-author, committer, or pusher unless explicitly requested.
