# Documentation & Testing Standard

## README
Must include: purpose, supported environments, installation, quick start, authentication, common scenarios, command discovery, an error-handling example, security considerations, compatibility notes, contribution link, support policy, license. Never open with internal build details before user value.

## Command help
Every public command needs complete help (comment-based or reliably generated external help): `.SYNOPSIS .DESCRIPTION .PARAMETER .EXAMPLE .INPUTS .OUTPUTS .NOTES .LINK`. Examples must be executable and realistic, never containing real secrets. Include `-WhatIf` examples for mutating commands. Document defaults, parameter-set behavior, pipeline binding, auth requirements, permissions, possible destructive effects, output type, notable errors.

## PlatyPS workflow
Use only when external Markdown/MAML help provides real maintenance value. Choose one authoritative direction (command metadata -> Markdown, or maintained Markdown -> external help) - never a circular workflow with unpredictable manual edits. Validate documentation freshness in CI.

## Examples and changelog
Keep runnable examples in `examples/`, using the public API only - never teaching consumers to call private functions. Test representative examples as smoke/acceptance tests. Changelog categories: Added, Changed, Deprecated, Removed, Fixed, Security. Document breaking changes clearly - never generate a meaningless commit dump.

## Testing standard (Pester 5+)
Tests validate behavior, not implementation trivia.

- **Unit**: command logic, validation, mapping, error translation, `ShouldProcess`, pagination/retry decisions, configuration precedence, secret redaction. Mock external boundaries, not every internal function.
- **Integration**: module import, manifest validity, command exports, help availability, formatting files, dependency loading, filesystem integration, API client integration against controlled services, binary assembly loading, supported runtime combinations.
- **Acceptance**: user-facing scenarios through public commands only - never call private functions.
- **Contract** (remote APIs / provider interfaces): request shape, response mapping, extension contract, backward compatibility, error normalization.
- **Security**: injection payloads, unsafe paths, redaction, permission failure, invalid certificates where feasible, untrusted response values, archive traversal, excessive input sizes, auth fallback, secret absence in logs/errors.

**Naming**: `Get-ContosoWidget.Tests.ps1`, `Module.Import.Tests.ps1`, `Manifest.Tests.ps1`, `PublicApi.Tests.ps1`, `Security.Tests.ps1`. Clear `Describe/Context/It` names that state expected behavior.

**Isolation**: avoid user production config, real production tenants, persistent machine changes; clean up resources; use unique test identifiers; support repeated and parallel execution. Use `TestDrive:` for filesystem tests. Never assume execution order.

**Mocking**: mock at stable boundaries (HTTP client, filesystem adapter, time provider, randomness provider, external module command, credential provider) - never the function under test, and avoid over-mocking private details so tests tolerate safe refactoring.

**Coverage**: set an initial target appropriate to maturity - normally at least 80% for mature modules, higher for security-critical core logic. Coverage percentage is not proof of quality - require explicit tests for critical branches regardless of aggregate coverage. Fail CI below the agreed threshold once a baseline exists. Exclude generated code only with documented justification.

**Mutation/regression**: consider mutation testing or fault injection for critical modules. Every production bug fix should add a regression test that fails before the fix and passes after.

## PSScriptAnalyzer standard
Version-controlled settings file, e.g. `.config/powershell/PSScriptAnalyzerSettings.psd1`, with a deliberate rule set. Treat results by severity and project policy - never suppress a rule globally for one legitimate exception; scope each suppression narrowly with a justification. CI fails on analyzer errors and agreed warning classes. Analyze source, module files, build scripts, and tests when appropriate; exclude generated code only deliberately. Never auto-format code in release CI without reviewing the resulting diff.
