# Generate-CI.md

Use this file when you want an AI to turn `CI.md` into executable pipeline files.

## Prompt

> Use the project-bootstrap skill.
> Load `CI.md` and generate an executable CI implementation for this project.
> Target provider: {{CI_PROVIDER}}
> Runtime: {{LANGUAGE_OR_RUNTIME}}
> Build tool: {{BUILD_TOOL}}
> Test tool: {{TEST_TOOL}}
> Release model: {{RELEASE_MODEL}}
> Existing constraints: {{LIST_ANY_KNOWN_CONSTRAINTS}}

## Operating rule for the AI

- Preserve the stage semantics and security gates from `CI.md`.
- Keep provider syntax isolated from policy content.
- Choose the smallest working pipeline that satisfies the project.
- Do not add release publishing unless the project actually needs it.

## Required output

1. chosen provider and rationale
2. assumptions and unresolved inputs
3. generated pipeline file(s)
4. required secrets and variables
5. trigger rules
6. local reproduction commands
7. validation checklist
8. known limitations
