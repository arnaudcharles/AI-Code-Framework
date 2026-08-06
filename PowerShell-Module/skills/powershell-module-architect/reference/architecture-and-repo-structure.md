# Architecture & Repository Structure

## Selecting a profile
Pick exactly one. Do not force a small module into a large profile's complexity, and do not force a large domain into a script-only shape.

### Profile A - Compact script module
Use when: small/medium, mostly PowerShell, no complex binary dependencies, limited command count and coupling, files stay understandable.

```
{{ModuleName}}/
  src/{{ModuleName}}/
    {{ModuleName}}.psd1
    {{ModuleName}}.psm1
    Public/
    Private/
    en-US/
    {{ModuleName}}.format.ps1xml
  tests/{Unit,Integration,Acceptance,TestCases}/
  docs/
  examples/
  build/
  .github/workflows/
  .config/powershell/
  CHANGELOG.md CONTRIBUTING.md LICENSE README.md SECURITY.md build.ps1
```
Do not create empty directories for looks. Create `Private`, localization, formatting, or test categories only when they hold real assets.

### Profile B - Layered script module
Use when: many commands, significant shared services (API access, caching, serialization, mapping, config) - the public/private split alone no longer suffices.

```
src/{{ModuleName}}/
  {{ModuleName}}.psd1  {{ModuleName}}.psm1
  Public/
  Private/{Authentication,Clients,Conversion,Validation,Errors,Utilities}/
  Classes/ Enums/ Resources/ Formats/ Types/ en-US/
```
Use domain-oriented private folders, not generic dumping grounds. Avoid both `Private` and `Internal` unless they have a defined semantic split:
- `Private`: PowerShell implementation functions available module-wide.
- `Internal`: non-command assets, generated artifacts, internal types, build-time support - never dot-sourced as functions.
Never export anything from either.

### Profile C - Binary module
Use when: performance justifies compiled code, strong typing improves correctness, runspace/async integration is required, reusable .NET libraries exist, or IP/deployment needs justify compilation.

```
src/{{ModuleName}}/
  {{ModuleName}}.csproj Cmdlets/ Models/ Services/ Validation/ Exceptions/ Resources/ Properties/
src/{{ModuleName}}.PowerShell/
  {{ModuleName}}.psd1 {{ModuleName}}.psm1 Formats/ Types/ en-US/
tests/{Unit,Integration,PowerShell}/
```
Keep PowerShell-specific behavior in cmdlets or the PowerShell adapter layer. Keep reusable business logic in plain .NET services that do not depend on `PSCmdlet` unnecessarily.

### Profile D - Hybrid module
Use when compiled services/cmdlets add value but PowerShell functions still provide orchestration, convenience, formatting, aliases, argument completers, or bootstrap logic. Clearly identify which public commands are binary cmdlets vs. advanced functions. Never implement the same public command in both layers.

### Profile E - Multi-module suite with meta-module
Use only when the domain is too large for one package, users benefit from installing individual workloads, components have independent release/ownership boundaries, and segmentation reduces discovery/import cost.

```
src/{Product}/            meta-module manifest
src/{Product}.Authentication/
src/{Product}.Core/
src/{Product}.{WorkloadA,WorkloadB}/
```
Meta-module mainly declares dependencies and installation convenience. Never duplicate commands in it. Centralize shared auth only with carefully controlled versioning. Avoid circular dependencies.

### Profile F - Generated API SDK
Use only when the command surface is generated from a formal contract (e.g. OpenAPI), regeneration is reproducible, generated/handwritten code are strictly separated, customization hooks survive regeneration, and API changes are reviewed for command-surface impact.

```
generator/ metadata/ src/generated/ src/custom/ tests/generated/ tests/custom/
```
Never manually patch generated files without updating the generation source. Record generator version, metadata version, generation command.

### Profile G - Provider or extension framework
Use for pluggable secret vaults, package providers, extensibility contracts, host integrations, predictors/registration-based components. Define: interface contract, capability discovery, registration model, lifecycle, compatibility policy, error contract, security boundary, third-party validation strategy. Version the extension contract independently when needed.

## Repository & directory rules
- `src/` is the canonical source root for new projects. Use `tests/`, never both `test/` and `tests/`.
- Lowercase infra dirs: `src`, `tests`, `docs`, `examples`, `build`, `.github`.
- Module payload names preserve exact casing (`Contoso.Widget`, `Contoso.Widget.psd1/.psm1`). Manifest basename, module directory, and declared module name must match casing exactly. Do not mix `ContosoWidget` / `Contoso.Widget` / `contoso-widget` unless deliberate and documented.
- One public command per source file (unless a few tiny, inseparable commands form one implementation unit). Filename matches function name: `Public/Get-ContosoWidget.ps1`. Same convention for private functions: `Private/ConvertTo-ContosoRequest.ps1` - no `_` prefix.
- Avoid generic filenames (`Helpers.ps1`, `Utils.ps1`, `Common.ps1`, `Misc.ps1`) - use responsibility-based names.
- If dot-sourcing files: enumerate explicit directories, sort filenames, fail import with a clear error if a required file cannot load, never dot-source tests/examples/build files, never use user-controlled paths.
- For large modules, prefer a build step that composes/packages the module over expensive uncontrolled import-time discovery.
- The source tree and release artifact may differ - never publish repository-only content accidentally.

## Module bootstrap (import-time) rules
The root module must do as little as possible at import. Never at import time: network requests, authentication, telemetry calls, creating user files (unless explicitly required), modifying global preferences, modifying `PSModulePath`, installing dependencies, self-updating, starting background jobs, scanning the filesystem, printing banners, prompting the user.

Allowed at import: loading implementation files, loading compiled assemblies, loading localization data, initializing immutable module-scoped metadata, registering argument completers/type accelerators when safely reversible, validating mandatory packaged assets.

If initialization can fail, produce an actionable terminating error identifying: failing component, expected condition, actual condition, remediation. If module cleanup uses `OnRemove`, make it idempotent and never assume it always runs.
