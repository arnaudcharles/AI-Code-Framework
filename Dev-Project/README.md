# Dev-Project

Generic bootstrap and resume base for software projects.

## Overview

This base stays intentionally simple because it is meant to work across many project types. It gives Claude a lean operating contract, a living state file, and a small documentation model that keeps context switching safe.

Claude will say `READY` when the base is complete enough to continue in a fresh conversation.

When the context window becomes too wide, Claude will say `NEWCHAT` to recommend a new conversation. If the work is still active, use `/compact` and continue; if the base is stable, start the new chat.

## Structure

- `CLAUDE.md` - stable project rules, working principles, architecture constraints, commands, and durable context.
- `PROJECT.md` - living state: status, decisions, tasks, blockers, open questions, next steps.
- `SECURITY.md` - secret handling, trust boundaries, safe-development rules.
- `CONTRIBUTING.md` - collaboration rules for contributors.
- `/docs` - technical, functional, and product reference documentation.
- `/manuals` - user-facing manuals, examples, commands, troubleshooting, and operational instructions.

## How to use it

- Read `CLAUDE.md` first for stable operating rules.
- Read `PROJECT.md` for the current state of the work.
- Read `SECURITY.md` before touching sensitive or security-related code.
- Read `CONTRIBUTING.md` before proposing changes.
- Read `/docs` when you need detailed reference material.
- Read `/manuals` when you need usage instructions or examples.

## Token management

Keep the context window small. Work in small iterations, use `/compact` when the conversation gets dense, and start a new chat when the current thread is no longer token-efficient.

When the base is stable enough to continue elsewhere, Claude should say `READY`. When the thread becomes too wide or too repetitive, Claude should proactively say `NEWCHAT` and recommend restarting the conversation.

## Invocation

Use the project-bootstrap skill to start a new project or to restructure an existing one.

- New project: provide the project idea and let the skill initialize the base.
- Existing project: resume from the committed documentation and the current source tree.

## CI and release

If the project needs CI, the template includes the same portable pattern used by the other bases:
- `CI.md` for the provider-agnostic pipeline specification
- `Generate-CI.md` for turning `CI.md` into an executable provider-specific pipeline

## Cross-agent model

Use one canonical file plus thin pointers for each agent.

- `AGENTS.md` - canonical source of truth
- `CLAUDE.md` - Claude pointer to `AGENTS.md`
- `.github/copilot-instructions.md` - Copilot pointer to `AGENTS.md`

Each agent reads its own file, which redirects to `AGENTS.md`. No rule is duplicated.