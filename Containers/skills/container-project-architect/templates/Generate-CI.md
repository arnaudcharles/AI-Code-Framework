# Generate-CI.md

Use this file when you want an AI to turn `CI.md` into executable pipeline files for a specific CI provider.

## Purpose

Translate the platform-agnostic CI contract into a concrete implementation for the target provider while preserving the same security gates, artifacts, and release rules.

## When to use

Use this prompt when:
- the project already has `CI.md`
- the team wants an executable CI implementation
- the target CI provider is known or can be chosen
- you want the AI to generate the pipeline files, not just describe them

## Operating rule for the AI

Load and follow:
- `AGENT.md`
- `PROJECT.md`
- `container.md`
- `CI.md`
- `SECURITY.md`
- any existing pipeline files in `.github/`, `.gitlab-ci.yml`, `azure-pipelines.yml`, `Jenkinsfile`, or equivalent

Do not invent a different policy than the one in `CI.md`. Preserve the stage semantics, security gates, artifact chain, and release rules.

## Invocation

> Use the container-project-architect skill.
> Load `CI.md` and generate an executable CI implementation for this project.
> Target provider: {{CI_PROVIDER}}
> Preferred language/runtime: {{LANGUAGE_OR_RUNTIME}}
> Deployment target: {{compose|swarm|both|other}}
> Security profile: {{baseline|recommended|advanced}}
> Registry: {{REGISTRY}}
> Release model: {{TAG_AND_PROMOTION_MODEL}}
> Existing constraints: {{LIST_ANY_KNOWN_CONSTRAINTS}}

## Required output from the AI

1. Chosen provider and why it fits the project
2. Assumptions and unresolved inputs
3. Generated pipeline file(s)
4. Required secrets and variables
5. Trigger rules and branch protection requirements
6. Local reproduction commands
7. Validation checklist
8. Known limitations or follow-up items

## Generation rules

- Prefer the smallest executable pipeline that satisfies `CI.md`.
- Keep provider-specific syntax isolated from policy content.
- Do not weaken security gates without explicit approval.
- If a capability is unavailable on the target provider, explain the closest safe alternative.
- If release signing, SBOM, or attestation is required by policy, include it explicitly.
- If matrix builds are needed, keep them tied to actual runtime or platform requirements.

## Output shape guidance

The AI should usually produce:
- one main pipeline file
- optional reusable workflow/template files
- optional docs for required secrets and branch protection
- optional local helper scripts only if they materially improve reproducibility

## Compatibility rule

If a repository already has a CI implementation, treat it as the compatibility baseline unless you are explicitly replacing it. Do not rename or remove existing pipeline behavior casually.
