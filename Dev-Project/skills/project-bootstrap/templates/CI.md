# CI.md

Platform-agnostic CI specification for a general software project.

## Purpose

Define the minimum pipeline contract so an AI can turn it into an executable CI implementation for the chosen provider.

## Core stages

1. preflight
2. lint
3. test
4. build
5. package
6. validate
7. publish (optional, protected refs only)

## Required behavior

- Fail closed on lint or test failures.
- Keep builds reproducible and deterministic.
- Keep secrets out of source, logs, and generated YAML.
- Use the smallest provider-specific pipeline that satisfies the contract.

## Typical inputs

- language/runtime
- package manager
- build tool
- test framework
- target CI provider
- release model

## Typical outputs

- pipeline file(s)
- required secrets and variables
- trigger rules
- local reproduction commands
- validation checklist

## Definition of done

CI is complete when the selected provider can run lint, test, build, and release gates from the generated pipeline without weakening the policy described here.
