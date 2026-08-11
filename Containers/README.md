# Containers

Collection of prompts and a skill to design, build, test, secure, and operate production-grade container projects with a lean token footprint.

## Positioning

Same philosophy as `Dev-Project` and `PowerShell-Module`:
- Thin entry prompts.
- One canonical skill with strict operating rules.
- Topic-focused references loaded only when needed.
- Practical templates ready to copy.

## Structure

- `Prompt.md` - start a new container-first project.
- `Resume-prompt.md` - continue an existing container-first project.
- `skills/container-project-architect/SKILL.md` - operating contract.
- `skills/container-project-architect/reference/*.md` - detailed standards split by concern.
- `skills/container-project-architect/templates/` - ready scaffold with Dockerfile, Compose, CI, docs pointers, and `container.md` best practices.

## Why this split

A giant prompt is expensive and drifts quickly. Splitting keeps quality high while reducing token waste:
- `SKILL.md` is always loaded.
- `reference/*.md` files are loaded only when relevant.
- `templates/` are copied once and then adapted.

## Invocation

Use `container-project-architect` with your project specification from `Prompt.md`.

To resume:

Use `Resume-prompt.md`, then continue from `AGENTS.md`, `PROJECT.md`, `container.md`, and the existing container files.
