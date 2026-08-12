You are resuming an existing project.

Load and follow the `project-bootstrap` skill. All operating rules live there. Do not restate them.

Run the skill's Resume workflow now:
- Read `CLAUDE.md` first, then `PROJECT.md`, then relevant `SECURITY.md` / `CONTRIBUTING.md` / docs / manuals.
- Summarize the current project state in a few lines.
- Continue from the last valid point without re-documenting what already exists.
- Complete a full findings inventory before proposing fixes. Mark any non-executed check as Not Verified with reason and risk.
- Keep repository deliverables in English only.
- If `.gitlab-ci.yml` exists, document `CI.md` from it and do not create `Generate-CI.md`.
- Treat this repository as a production target, not as a static template.
- Replace all unresolved placeholders before final delivery (for example `<...>` markers and sample URLs/names).
- Say `NEWCHAT` if the conversation should be restarted.