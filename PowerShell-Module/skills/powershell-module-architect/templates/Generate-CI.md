# Generate-CI.md

Use this file when you want an AI to turn `CI.md` into executable pipeline files for a PowerShell module.

## Prompt

> Use the powershell-module-architect skill.
> Load `CI.md` and generate an executable CI implementation for this module.
> Module name: {{MODULE_NAME}}
> Target provider: {{CI_PROVIDER}}
> PowerShell version: {{PS_VERSION}}
> Gallery release: {{true_or_false}}
> Signing required: {{true_or_false}}
> Existing constraints: {{LIST_ANY_KNOWN_CONSTRAINTS}}

## Operating rule for the AI

- Preserve the module compatibility contract.
- Keep provider syntax separate from policy.
- Generate lint, test, build, package, validate, and release stages only as needed.
- If release publishing is enabled, include required secret inventory and branch protection rules.

## Required output

1. chosen provider and rationale
2. assumptions and unresolved inputs
3. generated pipeline file(s)
4. required secrets and variables
5. trigger rules and release gating
6. local reproduction commands
7. validation checklist
8. known limitations
