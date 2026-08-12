# Generate-CI.md

Use this file to generate executable CI files from CI.md.

## Prompt

Use the puppet-module-architect skill.
Load CI.md and generate executable pipeline files.

Module name: {{MODULE_NAME}}
CI provider: {{CI_PROVIDER}}
Puppet version matrix: {{PUPPET_MATRIX}}
Ruby version: {{RUBY_VERSION}}
Release enabled: {{true_or_false}}
Known constraints: {{CONSTRAINTS}}

## Rules

- Preserve CI.md policy intent.
- Keep provider syntax separate from policy.
- Include lint, test, package, validate, and optional publish stage.
- Include required secrets inventory for release.

## Required output

1. assumptions
2. generated pipeline files
3. required secrets and variables
4. trigger and gating rules
5. local reproduction commands
6. validation checklist
7. known limitations
