# Metadata, Dependencies, And Release

## metadata.json rules

- Keep name, version, author, source, summary, and license accurate.
- Pin supported Puppet and OS ranges in requirements.
- Keep dependencies explicit and minimal.

## Versioning policy

- Use semantic versioning.
- Major: breaking class or defined type interface changes.
- Minor: backward-compatible features.
- Patch: backward-compatible fixes only.

## Dependency policy

- Avoid broad dependency ranges with unknown behavior impact.
- Review transitive dependency risk during updates.
- Track dependency changes in changelog and release notes.

## Release gates

- metadata-json-lint passes.
- puppet-lint passes.
- rspec-puppet test suite passes.
- acceptance or compile matrix passes for declared support.
- security checks pass with no unreviewed critical issues.
