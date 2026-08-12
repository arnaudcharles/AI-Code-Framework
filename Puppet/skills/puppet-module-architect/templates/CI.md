# CI.md

Platform-agnostic CI contract for Puppet modules.

## Required stages

1. preflight
2. lint
3. test
4. package
5. validate
6. publish (release only)

## Mandatory checks

- puppet parser validate
- metadata-json-lint
- puppet-lint
- rspec-puppet
- dependency and secret hygiene checks

## Release controls

- publish only from protected refs
- fail if required release secrets are missing
- fail on unresolved critical/high findings
- require explicit major-version approval for breaking changes
