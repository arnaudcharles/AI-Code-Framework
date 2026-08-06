# Style, Build, CI, Release & Signing

## Style
Four-space indentation; one consistent brace style; one parameter attribute/type/name grouping per parameter; splatting for long invocations; descriptive names; no aliases in module source; no ambiguous positional invocation; no backtick line continuation unless unavoidable; no semicolon statement compression; consistent encoding; newline at end of file.

```powershell
$RequestParameters = @{
    Method      = 'Get'
    Uri         = $Uri
    Headers     = $Headers
    ErrorAction = 'Stop'
}
Invoke-RestMethod @RequestParameters
```
Do not splat a trivial two-argument call just to look sophisticated. Single quotes for literal strings, double quotes for interpolation; use format strings over hard-to-read nested interpolation. Comments explain why, never narrate the obvious; remove commented-out code.

## Build system
One discoverable entry point, `./build.ps1`, running cleanly and non-interactively in CI. Recommended tasks: `Clean, Restore, Compile, Analyze, Test, TestUnit, TestIntegration, BuildModule, ValidateManifest, GenerateHelp, Package, Sign, Publish, Release`. Use an existing build framework only when it improves maintainability - never combine several without reason. Output goes to a disposable directory (`output/`, `artifacts/`); never modify source files unexpectedly during ordinary test tasks. The package task must produce the exact install layout:
```
{{ModuleName}}/{{Version}}/{{ModuleName}}.psd1
{{ModuleName}}/{{Version}}/{{ModuleName}}.psm1-or-DLL
{{ModuleName}}/{{Version}}/packaged assets
```
Validate the artifact by importing it from the artifact path, not just `src`.

## Continuous integration
Separate stages: repository hygiene -> syntax/manifest validation -> static analysis -> unit tests -> integration tests -> cross-platform matrix -> compatibility matrix -> package build -> package import smoke test -> documentation validation -> security scanning -> artifact upload. Pin or deliberately version GitHub Actions. Default to minimal permissions:
```yaml
permissions:
  contents: read
```
grant more only per job when required. Never expose publishing secrets to pull-request workflows or run untrusted PR code with privileged secrets. Use concurrency cancellation for superseded builds; cache dependencies only with keys that prevent unsafe cross-contamination. Test the lowest supported PowerShell version and a current one; test all claimed operating systems; include a Windows PowerShell 5.1 job if claimed. Publish test results/coverage artifacts; fail visibly when no tests are discovered.

## Release pipeline
Reproducible from a reviewed commit: verify clean revision -> calculate version -> validate changelog -> run full test matrix -> build package -> import from artifact -> validate manifest/exports -> generate/validate help -> scan package contents -> sign applicable files -> produce checksums -> create immutable artifact -> publish prerelease/stable -> create release notes -> tag commit -> attach artifacts/checksums -> verify installation from the destination repository. Never publish from a normal PR job; use protected environments and, where available, separate credentials for prerelease vs. stable. Prevent accidental republishing of an existing version. Package must contain no test secrets, local config, editor files, coverage files, temp files, private certificates, unnecessary source maps, or build caches.

## Signing
Define exactly what is signed (scripts, module files, assemblies, package artifacts, checksums). Authenticode alone does not guarantee package safety. Protect signing keys, prefer managed signing services or hardware-backed keys, timestamp with an approved service, verify signatures after packaging, test signed artifacts in the real target environment, document what users should validate.

## Gallery / repository publication checklist
Validate: module name, ownership/namespace, manifest metadata, links, tags, license, release notes, required modules, minimum PS version, prerelease label, command naming, help, clean install, uninstall, import from a user module path. Never publish an unbounded dependency graph without testing clean install. Never use a placeholder `ProjectUri`/`LicenseUri`. Never change the module GUID between versions.

## Generated code policy
Generated files include a header with generator, generator version, source metadata, regeneration command, manual-edit policy (omit unstable timestamps that create meaningless diffs). Keep generated and handwritten code separate. CI should regenerate and fail on drift when generation is deterministic. Test custom transformations; review generated public-API changes as carefully as handwritten ones. Never assume generated code is secure or idiomatic by default - run analyzer, tests, formatting, and API review per an explicit policy.
