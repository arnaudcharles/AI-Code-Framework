# Claude project orchestration

Collection of prompt to work better with Claude on projects, avoiding high token cosumption.

# Dev-Project

A prompt to set best practices to start a dev projects

# Tips

## Init
If a project is already existing, type `/init` to let Claude build automaticaaly the CLAUDE.md

## Context
Keep the context window small. Try to break action in small iterations.

Do `/compact` at 60% and `/clear` between tasks.


## Skills
In case of industrial way of working, you can think of building a skill that Claude will load and use instead of repeating prompts.
See Skills.

### Making it a real Claude skill
The `Dev-Project/skills/project-bootstrap/` folder is a skill *template*. For Claude Code to auto-discover and load it, the folder must live in a conventional location. Claude reads the `SKILL.md` at the root of the skill folder:

- `~/.claude/skills/project-bootstrap/SKILL.md` - personal skill, available in all projects.
- `.claude/skills/project-bootstrap/SKILL.md` - project skill, versioned in the repo and shared with the team.

General form:

- `~/.claude/skills/<skill-name>/SKILL.md` (personal skills, all projects)
- `.claude/skills/<skill-name>/SKILL.md` (project skills, versioned in the repo)

Copy the `project-bootstrap` folder into one of those locations, then Claude finds it automatically from its `SKILL.md` frontmatter (`name` + `description`). Kept here, it is a reusable template, not an active skill.

To invoke them, use:

> Use the project-bootstrap skill.
Here is my project idea:
[describe the project]

If it's a work in progress project, invoke it with:

> Use the project-bootstrap skill only if the project needs restructuring.
Otherwise resume from the provided documentation and continue from the current state.

## Cross-agent instructions
To support agents other than Claude (Copilot, Codex, etc.), use one canonical file plus thin pointers instead of one big `CLAUDE.md`:

- `AGENTS.md` - the single source of truth (emerging cross-agent convention).
- `CLAUDE.md` - a short pointer to `AGENTS.md` (what Claude reads).
- `.github/copilot-instructions.md` - a short pointer to `AGENTS.md` (what GitHub Copilot reads).

Each agent reads its own file, which redirects to `AGENTS.md`. No rule is duplicated. See the templates in `Dev-Project/skills/project-bootstrap/templates/`.