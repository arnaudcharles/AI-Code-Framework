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

To invoke them, use:

> Use the project-bootstrap skill.
Here is my project idea:
[describe the project]

If it's a work in progress project, invoke it with:

> Use the project-bootstrap skill only if the project needs restructuring.
Otherwise resume from the provided documentation and continue from the current state.