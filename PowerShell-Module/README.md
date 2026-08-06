# PowerShell Module Orchestration

Collection of prompts and a skill to design, build, and release production-grade PowerShell modules with Claude, without pasting a 48-section master prompt into every conversation.

# Dev-Project vs PowerShell-Module

Same philosophy as `Dev-Project`: a lean entry prompt that loads a skill, and the skill holds the actual standard. Here the standard is PowerShell module engineering instead of generic project bootstrap.

# Structure

- `Prompt.md` - start building a new module.
- `Resume-prompt.md` - continue an existing module.
- `skills/powershell-module-architect/SKILL.md` - the operating contract: role, order of authority, working method, non-negotiable principles, final response format, self-review. Kept short.
- `skills/powershell-module-architect/reference/*.md` - the detailed standard (naming, manifest, security, testing, CI/release, etc.), loaded only when the task touches that topic. This is where the bulk of the original 48-section prompt lives, split by concern.
- `skills/powershell-module-architect/templates/` - a ready-to-copy scaffold for a compact script module (Profile A): manifest, loader, example public/private function, Pester tests, PSScriptAnalyzer settings, CI workflows, build script, and the cross-agent doc pointers.

# Why split instead of one big prompt

A single 30k-word prompt costs tokens on every turn and invites drift (the model re-reads rules it does not need for the current step). Splitting means:
- `SKILL.md` stays small and is always loaded.
- `reference/*.md` files are read only when relevant (e.g. touching auth code loads `authentication-clients-config.md`, not the whole standard).
- `templates/` are copied once when scaffolding, not re-explained every turn.

# Making it a real Claude skill

Copy `skills/powershell-module-architect/` into:
- `~/.claude/skills/powershell-module-architect/SKILL.md` for personal use across all repos, or
- `.claude/skills/powershell-module-architect/SKILL.md` inside a specific module repo to version it with the code.

# Invocation

> Use the powershell-module-architect skill.
> Module name: Contoso.Widget
> Purpose: ...
> [fill in the rest of the project specification, or let it propose one]

To resume an existing module:

> Use the powershell-module-architect skill only if the module needs restructuring.
> Otherwise resume from AGENTS.md/CLAUDE.md, README.md, CHANGELOG.md, and the current source tree.

# Cross-agent instructions

Generated modules use `AGENTS.md` as the canonical instructions file, with `CLAUDE.md` and `.github/copilot-instructions.md` as thin pointers - same pattern as `Dev-Project`.
