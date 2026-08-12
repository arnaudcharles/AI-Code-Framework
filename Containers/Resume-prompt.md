You are resuming work on an existing container-first project.

Load and follow the `container-project-architect` skill. Load `reference/*.md` files only for topics this session touches.

Run the skill's resume workflow:
- Read `AGENTS.md` (or `CLAUDE.md`), `PROJECT.md`, `container.md`, `README.md`, and current Docker/Compose/Swarm files first.
- Detect and preserve the established compatibility contract (image naming/versioning, env vars, ports, healthchecks, volume contracts, Compose service names).
- Summarize current state in a few lines: architecture profile, image/runtime base, current controls, missing controls.
- Continue from the last valid point without re-documenting what already exists.
- Treat the repository as a production target, not as a static template.
- Replace all placeholder values before final delivery (for example: sample image tags, sample secret names, and unresolved <...> markers).
- If a change is breaking (runtime, env vars, image contract, deployment behavior), say so explicitly before implementing it.