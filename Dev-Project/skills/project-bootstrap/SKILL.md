---
name: project-bootstrap
description: Bootstrap a new software project with CLAUDE.md, PROJECT.md, SECURITY.md, CONTRIBUTING.md, docs, manuals, and context-switching rules.
---

# Project Bootstrap Skill

Use this skill when starting a new project or restructuring an existing one.

## Goals
- Create a clean, repeatable project foundation.
- Separate stable instructions from live project state.
- Minimize duplication across files.
- Make context switching safe and efficient.
- Standardize project bootstrapping across repositories.

## Required outputs
- `CLAUDE.md`
- `PROJECT.md`
- `SECURITY.md`
- `CONTRIBUTING.md`
- `README.md`
- `/docs`
- `/manuals`

## Operating rules
- Ask only the minimum necessary questions.
- Prefer concise, production-grade Markdown.
- Do not duplicate content across files.
- Keep `CLAUDE.md` stable and concise.
- Keep `PROJECT.md` living and current.
- Keep `SECURITY.md` focused on secrets, trust boundaries, and safe development.
- Keep `CONTRIBUTING.md` focused on collaboration rules.
- Keep `/docs` for technical and product reference.
- Keep `/manuals` for user-facing usage guidance.
- State clearly when the base is `READY`.
- State clearly when a new conversation is needed with `NEWCHAT`.
- Never credit Claude as author in commits, pushes, or metadata.

## Workflow
1. Read the project idea.
2. Ask only essential questions.
3. Propose the documentation structure.
4. Generate the base files.
5. Fill only the docs that are actually needed.
6. Confirm when the base is ready for context switching.
7. Recommend `NEWCHAT` when the conversation becomes too dense or fragile.