You are resuming work on an existing PowerShell module.

Load and follow the `powershell-module-architect` skill. Load `reference/*.md` files only for the topics this session touches.

Run the skill's resume workflow:
- Read `AGENTS.md` (or `CLAUDE.md`), `README.md`, `CHANGELOG.md`, the manifest, and the current source tree first.
- Detect the module's established public API and compatibility contract (command names, parameters, output shape, error IDs). Preserve it unless I explicitly authorize a breaking release.
- Summarize the current state in a few lines: architecture profile in use, version, what is implemented, what is missing.
- Continue from the last valid point without re-documenting what already exists.
- If a change would be breaking, say so explicitly before implementing it.
