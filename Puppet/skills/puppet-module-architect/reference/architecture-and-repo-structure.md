# Architecture And Repository Structure

## Objective

Choose the simplest architecture that still satisfies operational and security requirements.

## Profiles

### Profile A: Single-purpose baseline module

Use when scope is narrow and one team owns lifecycle.

Required tree:
- manifests/init.pp
- metadata.json
- README.md
- data/common.yaml
- spec/classes/init_spec.rb

### Profile B: Operational module with defined types and templates

Use when resources are repeated with parameterized patterns.

Required additions:
- manifests/params.pp
- manifests/*.pp for defined types
- templates/*.epp
- files/

### Profile C: Multi-platform module with strict policy controls

Use when module must enforce hardening controls on multiple operating systems.

Required additions:
- dedicated profile classes
- compliance control mapping in docs
- acceptance tests per OS family

## Layering rules

- Keep parameter defaults and data contracts explicit.
- Keep business logic in manifests, data in Hiera files, text rendering in EPP templates.
- Avoid hidden ordering by using explicit relationships when ordering matters.
- Keep class interfaces stable and backward compatible unless major release.

## Repository baseline

- metadata.json
- manifests/
- templates/
- files/
- data/
- spec/
- CI.md
- Generate-CI.md
- AGENT.md plus pointer files
- PROJECT.md, SECURITY.md, CONTRIBUTING.md
- docs/ and manuals/

## Migration threshold

Move from A to B when repeated resource patterns or template variants appear.
Move from B to C when cross-platform compliance requirements and test matrix complexity justify stricter decomposition.
