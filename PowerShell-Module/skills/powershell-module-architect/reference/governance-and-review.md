# Governance & Review

## Git and contribution standard
Include: `.gitignore`, `.gitattributes`, editor config, contribution guide, code of conduct where appropriate, security policy, issue/PR templates, dependency-update config where appropriate. Use branch protection with required review for: public API changes, security-sensitive changes, release pipeline changes, dependency changes, permission changes, generated metadata changes. Keep commit messages clear; a changelog may follow conventional commits, labels, or curated entries - pick one method and stay consistent. Never require contributors to understand undocumented generation magic; provide bootstrap instructions.

## Backward-compatibility review
Before changing a public command, diff: command name, aliases, parameter names/aliases, types, mandatory status, position, parameter sets, pipeline binding, validation, defaults, output type, output property names, error IDs, confirmation behavior, auth behavior, side effects, ordering guarantees, pagination semantics. Adding validation can be breaking if previously accepted values are now rejected. Changing output property casing can break consumers. Turning a non-terminating error into a terminating one can break workflows. Changing default ordering can break consumers even if undocumented. Treat observable behavior as potential API surface. Generate an API compatibility report for mature modules.

## Reference-project lessons (adopt selectively, never wholesale)
- **PSScriptAnalyzer**: automated static analysis, explicit rule config, strong regression tests, clear diagnostics. Do not treat every warning as universally correct without context.
- **PowerShell**: stable cmdlet semantics, deliberate error records, approved naming, compatibility awareness, strong regression testing. Do not copy engine-level complexity into an ordinary module.
- **SecretManagement/SecretStore**: provider contracts, capability separation, secret redaction, explicit auth/vault boundaries, secure defaults. Never invent custom cryptography or claim security without a defined threat model.
- **PSResourceGet/PackageManagement**: provider abstractions where genuinely required, explicit package identity/versions, deterministic dependency behavior, robust error handling. Do not reproduce a provider framework for one fixed service.
- **ThreadJob**: focused API, correct lifecycle, native abstraction integration, concurrency testing. Do not add jobs when synchronous execution suffices.
- **PSReadLine / Az.Tools.Predictor**: responsiveness, minimal import-time blocking, host integration discipline, cancellation/latency awareness, user control over interactive features. Never make unsolicited network calls during import or interactive typing.
- **PlatyPS**: documentation-as-code, external help generation, validated command/help sync. Never let generated docs and behavior drift.
- **Pester**: behavior-focused tests, deterministic discovery, clean build/test separation. Never overfit architecture just to make mocking easy.
- **dbatools** (at scale): consistent command experience, shared internal services, strong docs and contribution conventions, centralized error/messaging, domain-focused naming. Do not copy its scale-driven complexity into a small module.
- **PSFramework**: structured configuration, logging abstraction, localization, reusable services - only where required, never as a default mandatory dependency.
- **ImportExcel**: task-oriented commands, strong usability, practical examples, rich object handling. Keep presentation separate from core data objects.
- **Microsoft Graph PowerShell SDK** (large generated surfaces only): workload modules, shared auth, reproducible generation, meta-module packaging, metadata-driven commands, generated/custom separation. Never use a meta-module or hundreds of generated commands for a narrow API.

## Prohibited patterns
Never use or generate: `Invoke-Expression`; hardcoded secrets; plaintext passwords; globally modified error preferences without restoration; silent broad `catch`; empty `catch`; `catch { Write-Host $_ }`; wildcard manifest exports; undocumented exported variables; runtime dependency installation at import; network calls at import; destructive commands without `ShouldProcess`; `ShouldProcess` on read-only commands; a fake `OutputType`; empty `begin/process/end` blocks; pipeline binding on every parameter by default; formatting cmdlets inside data commands; success-stream output containing progress/log text; aliases in production source in place of full commands; unbounded retries; infinite polling; unsafe certificate bypass by default; user-controlled URI plus forwarded credentials without validation; arbitrary downloaded code execution; manually edited generated code; hidden breaking changes in a patch release; tests requiring production credentials; test-order dependence; uncontrolled mutable global state; premature custom frameworks; folders created solely for aesthetic completeness; classes used merely to look object-oriented; custom cryptographic primitives; unsupported "enterprise-grade" claims.

## Required file set
Typical production script module:
```
src/{ModuleName}/{ModuleName}.psd1
src/{ModuleName}/{ModuleName}.psm1
src/{ModuleName}/Public/*.ps1
src/{ModuleName}/Private/*.ps1
tests/Unit/*.Tests.ps1
tests/Integration/Module.Import.Tests.ps1
tests/Integration/Manifest.Tests.ps1
tests/Integration/PublicApi.Tests.ps1
.config/powershell/PSScriptAnalyzerSettings.psd1
.github/workflows/ci.yml
.github/workflows/release.yml
build.ps1  README.md  CHANGELOG.md  CONTRIBUTING.md  SECURITY.md  LICENSE
.gitignore  .gitattributes
```
Add when applicable: `docs/`, `examples/`, `Formats/*.format.ps1xml`, `Types/*.types.ps1xml`, `en-US/*.strings.psd1`, `Classes/`, `Enums/`, `generator/`, `Directory.Build.props`, `Directory.Packages.props`, `*.sln`/`*.csproj`, `CODEOWNERS`, `dependabot.yml`. Never let a release workflow publish successfully with placeholder credentials or URLs - make disabled/manual release behavior explicit until configured.

## CI acceptance gates
All expected test files discovered; unit/integration/acceptance tests pass; PSScriptAnalyzer policy passes; manifest validates; module imports from the packaged artifact; exported commands exactly match the approved API; no unexpected aliases/variables exported; command help exists; examples remain valid; version sources agree; package contains only approved files; minimum and current supported PowerShell versions pass; all claimed operating systems pass; Windows PowerShell 5.1 passes if claimed; coverage threshold passes; generated code is current; no committed secrets detected; dependencies pass the agreed vulnerability policy; release publication is blocked outside protected conditions.
