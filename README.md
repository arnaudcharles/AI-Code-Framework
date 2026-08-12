# AI-Code-Framework

This repository is a framework of reusable project bases for working with Claude and other coding agents without repeating a giant master prompt on every task.

## The four bases

- [Dev-Project](Dev-Project/README.md) - generic project bootstrap and resume flow for software projects.
- [PowerShell-Module](PowerShell-Module/README.md) - production-grade PowerShell module engineering.
- [Containers](Containers/README.md) - container-first projects, Docker/Compose/Swarm guidance, and portable CI specification.
- [Puppet](Puppet/README.md) - production-grade Puppet module engineering with secure-by-default controls and reusable scaffolding.

The bases solve different problems:
- `Dev-Project` is the generic bootstrap and resume base for software projects.
- `PowerShell-Module` is the production-grade base for PowerShell module engineering.
- `Containers` is the container-first base for Docker, Compose, Swarm, and portable CI.
- `Puppet` is the production-grade base for Puppet module architecture, data modeling, testing, and release governance.

None of these bases is a lower or higher tier in value. They are different tools for different project goals.

Each base follows the same pattern:
- a thin entry prompt for new work
- a thin resume prompt for existing work
- one canonical skill that holds the operating contract
- topic-focused references loaded only when relevant
- ready-to-copy templates for the actual project scaffold
- optional CI specification plus CI generator pair when the domain benefits from it

## How to use it

- Start a new project from the base that matches the problem domain.
- Resume an existing project from its resume prompt and live docs.
- Keep the context window small and work in small iterations.

## Why this structure works

- The prompt stays short and cheap.
- The rules stay in one canonical skill instead of being duplicated everywhere.
- The templates stay practical and executable instead of being abstract.
- The same pattern works across generic apps, PowerShell modules, and container projects.
- The framework can stay generic at the root while each base adds domain-specific structure only where it pays off.
- The token-saving model is deliberate: keep the context window small, use `/compact` when the thread gets dense, and restart with a new chat when the conversation is no longer efficient.

## Skills

Think of the `skills/*` folders as reusable skill templates. For Claude Code to auto-discover them, the folder must be copied into a real skill location such as:

- `~/.claude/skills/<skill-name>/SKILL.md` for personal use
- `.claude/skills/<skill-name>/SKILL.md` for repo-scoped use

Copied there, Claude loads the `SKILL.md` frontmatter and the skill becomes active. Kept in this repository, it remains a reusable source template.

## Cross-agent model

Each generated project should use one canonical instructions file plus thin pointers for each agent.

Default pattern used by Dev-Project, PowerShell-Module, and Containers:

- `AGENTS.md` - canonical source of truth
- `CLAUDE.md` - Claude pointer to `AGENTS.md`
- `.github/copilot-instructions.md` - Copilot pointer to `AGENTS.md`

Puppet base pattern:

- `agent.md` - canonical source of truth
- `CLAUDE.md` - pointer to `agent.md`
- `CODEX.md` - pointer to `agent.md`
- `DEEPSEEK.md` - pointer to `agent.md`
- `.github/copilot-instructions.md` - pointer to `agent.md`

Both patterns keep the rules single-sourced and easy to resume across conversations and tools.