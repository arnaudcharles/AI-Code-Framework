# Types, Compatibility, Performance & Localization

## Classes and enums
Use PowerShell classes when a stable public model benefits users, an internal stateful abstraction is genuinely clearer, or type validation materially improves correctness - but be cautious, class definitions have reload/dev-session implications. For widely consumed binary/public contracts, compiled .NET types often version and tool better. Use enums for stable closed sets - never for values an external service can add independently, unless unknown values are handled safely. Public model types must stay backward-compatible within a major version. Never expose implementation-only service classes as public output. Avoid deep inheritance; prefer composition.

## Compatibility policy
Declare an explicit compatibility matrix (example):

| Environment | Status |
|---|---|
| PowerShell 7.4 on Windows/Linux/macOS | Supported |
| PowerShell 7.2 | Supported minimum |
| Windows PowerShell 5.1 | Not supported (unless declared) |
| Constrained Language Mode | Partially supported (state which parts) |

Never claim compatibility that is not actually tested.

### Windows PowerShell 5.1
Support only when required. If supported: test on real 5.1, avoid later-version syntax, account for .NET Framework vs. modern .NET, encoding defaults, TLS behavior, unavailable cmdlet parameters; multi-target binary assemblies; test assembly binding, manifest discovery, and import; document platform-specific limitations. Never describe 5.1 support as "free compatibility" - `$IsWindows` etc. are not universally available there, so provide a compatible platform-detection abstraction.

### Cross-platform
Use `Join-Path`, `[System.IO.Path]`, platform APIs, `$IsWindows/$IsLinux/$IsMacOS` where supported. Never hardcode path separators, drive letters, `/tmp`, registry usage, executable extensions, case-insensitive filename assumptions, or CRLF-only parsing. Use invariant culture for machine-readable serialization/protocol values, user culture only for presentation. Test with case-sensitive filesystems.

### Constrained Language Mode
If required: avoid runtime type generation, prohibited reflection/dynamic-code patterns, unnecessary `Add-Type`; test under the actual constrained environment; document what cannot operate. Never claim CLM compatibility from static review alone.

## Performance
Optimize import time, execution, memory, and remote call count according to actual use cases.
- **Import**: explicit manifest exports, no network/disk scans at import, defer optional assembly loads when safe, avoid repeatedly parsing large generated trees. For very large modules, consider build-time composition, binary commands, preloading, or workload segmentation.
- **Pipeline**: stream large outputs, avoid `+=` array growth in loops (prefer generic collections for accumulation), avoid unnecessary `ForEach-Object` overhead in hot paths when a language loop is clearer and measurably faster. Never replace readable idiomatic PowerShell with obscure .NET code without evidence.
- **Remote**: reduce round trips, batch where supported, cache stable metadata, page appropriately, avoid N+1 calls, avoid requesting unnecessary fields when projection is supported.
- **Measurement discipline**: establish a representative benchmark, account for warm-up, compare alternatives, record data volume and environment, set regression thresholds with tolerance. Never claim a performance improvement without measurement.

## Localization
Use standard localization directories (`en-US/`, `fr-FR/`). Keep invariant identifiers (error IDs, telemetry event names, property names, config keys, protocol values) out of localized text. Use invariant culture for dates in APIs, numeric protocol values, version parsing, hashes, machine-readable files - never parse human-formatted dates/numbers when a structured type can be accepted instead. Ensure graceful fallback when a culture file is unavailable.
