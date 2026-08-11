# CI.md

Platform-agnostic CI specification for a PowerShell module.

## Purpose

Define the pipeline contract so an AI can generate executable CI for the target provider without changing module semantics.

## Required stages

1. preflight
2. lint
3. test
4. build
5. package
6. validate
7. publish (release only)

## Minimum checks

- syntax and manifest validation
- import validation
- unit and integration tests
- analyzer checks
- version and package consistency
- release gate protection

## Release requirements

- publish only from protected refs
- never publish with placeholder credentials
- preserve compatibility contract unless a breaking release is explicitly approved
- include required secret inventory and branch protection rules in the generated output

## Typical outputs

- provider-specific pipeline files
- local reproduction commands
- test and validation checklist
- required secrets and variables
- release/publish notes
