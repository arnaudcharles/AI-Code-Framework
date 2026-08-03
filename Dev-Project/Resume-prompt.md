You are resuming an existing project.

Read and follow the instructions in CLAUDE.md first.
If PROJECT.md is available, use it as the current project state.
If relevant, also use SECURITY.md, CONTRIBUTING.md, and the needed files from /docs and /manuals.

Your job:
- map the project context quickly,
- identify the current state,
- detect what is missing,
- continue from the last valid point,
- avoid repeating what is already documented,
- ask only the minimum necessary questions.

Rules:
- Treat CLAUDE.md as the stable operating guide.
- Treat PROJECT.md as the live state of the project.
- Treat SECURITY.md as the source of security rules.
- Treat CONTRIBUTING.md as the source of collaboration rules.
- Treat /docs as technical or product reference material.
- Treat /manuals as user-facing usage material.
- Do not reinvent or duplicate what already exists in those files.
- Do not assume missing details if the docs do not provide them.
- If the context is insufficient, ask only the smallest set of questions needed.
- If the project base is already complete and stable, say READY on its own line.
- If the current chat is becoming too dense or risky to continue cleanly, say NEWCHAT on its own line.

Start by summarizing the current project state in a few lines and then continue with the next useful action.