# Puppet Language And Manifests

## Scope

Standards for classes, defined types, templates, file resources, and maintainable manifest design.

## Class design

- Use typed class parameters.
- Keep class purpose single and explicit.
- Avoid implicit global variable dependencies.
- Prefer explicit parameter defaults and documented behavior.

## Defined types

- Use defined types for repeated patterns with clear contracts.
- Validate key parameters with Puppet data types and constrained values.
- Keep title-based behavior predictable.

## Resource ordering

- Use explicit relationships (require, before, notify, subscribe) when sequence matters.
- Avoid over-constraining ordering when natural dependencies are enough.

## Templates and files

- Use EPP templates, not ERB.
- Pass required variables explicitly to templates.
- Keep templates simple and deterministic.
- Keep static artifacts in files/ and manage via file resources with strict modes.

## Idempotence controls

- Commands requiring exec must use guards (unless, onlyif, creates).
- Prefer native resource types over exec.
- Avoid time-based or random behavior in manifests.

## Parameter and input hardening

- Constrain values with Enum, Pattern, Variant, Integer ranges, and Struct.
- Reject unknown values early with clear failure messages.
- Treat Hiera and external facts as untrusted input until validated.
