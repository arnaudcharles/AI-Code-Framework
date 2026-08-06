# Naming, Versioning & Manifest Standard

## Module name
Use a stable product/capability name: `Vendor.Product`, `Vendor.Product.Workload`, or `ProductName`. Use dotted names only when the namespace has genuine meaning. Never rename a published module casually - the name is part of the install/dependency contract.

## Command nouns and verbs
Use a consistent singular noun family and approved verbs: `Get-ContosoWidget`, `New-ContosoWidget`, `Set-`, `Remove-`, `Test-`, `Connect-ContosoService`, `Disconnect-ContosoService`. Use singular nouns even when multiple objects can be returned. Add a product-specific noun prefix only to prevent real collision (`Get-CwWidget`), never a cryptic or full-company prefix by default. Avoid redundant names (`Get-ContosoModuleWidgetFromContosoService`) - prefer `Get-ContosoWidget`.

## Casing
PascalCase for function names, parameters, classes, enums, public properties, named parameter sets. Do not encode type info in variable names (`$strName`, `$arrUsers`) - prefer `$Name`, `$Users`. Use canonical casing for automatic variables (`$PSCmdlet`, `$PSBoundParameters`, `$PSScriptRoot`).

## Booleans and aliases
Boolean parameters/properties describe a positive condition (`-IncludeDisabled`, `-Force`, `-PassThru`, `-AsJob`) - avoid double negatives. Use `[switch]`, not `[bool]`, for optional flags.
Do not export aliases by default. Add one only for established backward compatibility, a recognized product migration, or an approved usability need - document and test it. Never let an alias shadow an unrelated command.

## Semantic Versioning
`MAJOR.MINOR.PATCH`. Manifest: `ModuleVersion = '1.4.2'`. Prerelease via `PrivateData.PSData.Prerelease = 'preview.1'` (conceptually `1.4.2-preview.1`) - never embed prerelease text directly in `ModuleVersion`.

**MAJOR**: removed/renamed public command or parameter, incompatible parameter type change, changed default behavior that can break automation, changed output contract breaking property-based consumers, changed auth behavior requiring consumer changes, raised minimum PS version without an established window, incompatible extension-provider contract change.

**MINOR**: backward-compatible commands/parameters, new output properties that do not alter existing meaning, new optional integrations, new supported platforms, internal improvements with no breaking public behavior, deprecation notices for a future major.

**PATCH**: compatible bug fixes, doc fixes shipped with a release, performance improvements with unchanged semantics, security hardening that does not break supported usage, packaging fixes, compatible dependency updates.

Treat breaking security fixes individually - do not mislabel a breaking security change as a patch merely because it is urgent.

### Single source of version truth
Pick one canonical source (release metadata file, Git-tag-derived version, build config, or a carefully automated manifest). All of these must agree in a release artifact: manifest `ModuleVersion`, prerelease label, package version, Git tag, release title, changelog heading, assembly informational version (binary modules), displayed doc version. **Fail the build on mismatch.**

Git tags: `v1.4.2`, `v1.5.0-preview.1`. Never reuse or move a published release tag.

### Dependencies
Declare a minimum version only when all later compatible versions are acceptable. Use a maximum only with a verified incompatibility and a documented remediation plan. Use an exact version only when strict lockstep is necessary. Test the lowest supported dependency versions and the current set. For binary modules, detect assembly version conflicts in integration tests.

### Deprecation
Before removing a public command/parameter: mark deprecated -> emit a targeted, non-noisy notice -> provide a replacement -> document migration -> preserve through the announced window -> remove only in a major release. Never silently change semantics under an existing name.

## Manifest standard
Create with `New-ModuleManifest` at scaffold time, then maintain as reviewed source.

```powershell
@{
    RootModule           = 'Contoso.Widget.psm1'
    ModuleVersion        = '0.1.0'
    GUID                 = '00000000-0000-0000-0000-000000000000'
    Author               = 'Contoso Engineering'
    CompanyName          = 'Contoso'
    Copyright            = '(c) Contoso. All rights reserved.'
    Description          = 'Manage Contoso widgets.'
    PowerShellVersion    = '7.4'
    CompatiblePSEditions = @('Core')
    FunctionsToExport    = @('Get-ContosoWidget')
    CmdletsToExport      = @()
    VariablesToExport    = @()
    AliasesToExport      = @()
    FormatsToProcess     = @('Formats/Contoso.Widget.format.ps1xml')
    PrivateData = @{
        PSData = @{
            Tags         = @('Contoso','Widget','Automation')
            LicenseUri   = 'https://example.invalid/license'
            ProjectUri   = 'https://example.invalid/project'
            ReleaseNotes = 'Initial prerelease.'
            Prerelease   = 'preview.1'
        }
    }
}
```

Rules:
- Generate one stable GUID once - never regenerate it for routine releases.
- List exports explicitly. Never `FunctionsToExport/CmdletsToExport/AliasesToExport = '*'`. Use empty arrays when nothing to export.
- Do not export variables without a strong, reviewed compatibility reason.
- `RequiredModules` only for dependencies actually required at import/operation - never list dev-only tools (Pester, PSScriptAnalyzer) as runtime dependencies.
- `NestedModules` only when the architecture genuinely nests modules. Prefer avoiding `ScriptsToProcess` (runs in caller's session state). `RequiredAssemblies` only for packaged assemblies that must load before module processing.
- Every referenced file must exist in the package artifact with matching casing, including on case-sensitive filesystems.
- For Windows PowerShell 5.1 support, do not let `CompatiblePSEditions` incorrectly block supported use - test actual discovery/import.
