# Command & API Design

## Public command design checklist
Every public command represents one coherent user operation. Before approving one, answer: what user intent does it represent; why is it public; what object does it accept/emit; is it idempotent; does it mutate external state; can it be retried safely; what happens for zero/one/many results; how is partial failure represented; behavior under `-WhatIf` and `-ErrorAction Stop`; is output stable enough for automation. Never create a public command merely to expose an internal helper - prefer a small coherent API over a large convenience one.

## Advanced function baseline
```powershell
function Get-ContosoWidget {
    [CmdletBinding()]
    [OutputType([Contoso.Widget.WidgetInfo])]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name
    )
    # Implementation
}
```
- `[CmdletBinding()]` on public functions unless documented otherwise; optional on trivial private helpers.
- `[OutputType()]` only when the contract is stable and accurately representable - never to satisfy a checklist. Account for parameter-set-specific output. `OutputType` does not enforce runtime output; tests must verify the real contract.
- `begin/process/end`: use `process` for per-item pipeline handling, `begin` for shared init, `end` for aggregation/cleanup. Never leave an empty block. A collection parameter alone does not make a command a streaming pipeline command.
- Never redeclare common parameters (`Verbose`, `Debug`, `ErrorAction`, `WarningAction`, `InformationAction`, `ErrorVariable`, `OutVariable`, `PipelineVariable`).
- Avoid positional parameters by default; use them only for a well-established, unambiguous pattern - never leave multiple parameters positionally ambiguous.
- Declare `DefaultParameterSetName` when multiple sets exist. Every set must represent a valid operation; do not use sets as a substitute for validation of conceptually identical operations. Avoid combinatorial explosion of sets.

## Parameter design
Prefer PowerShell-friendly types (`string`, `int`, `long`, `datetime`, `timespan`, `uri`, `guid`, `version`, `cultureinfo`, `pscredential`, domain enum, stable model type). Avoid `[object]` unless heterogeneous input is intentional and documented. Avoid `[hashtable]` for complex public contracts. Use `[switch]` for flags, `[Nullable[T]]` only when absence must differ from the type's default.

- **Mandatory**: only when the operation truly cannot proceed without it. Do not force values derivable from pipeline, config, or an authenticated context. Do not prompt interactively unless that is the command's explicit purpose.
- **Validation**: correct, deterministic, fast, side-effect-free, with clear failure messages for custom validation. Use `ValidateNotNull(OrEmpty)`, `ValidateRange/Length/Count/Pattern/Set`, `ValidateScript`, enums, or custom attributes (binary modules) when justified. Never add `ValidateNotNullOrEmpty` where empty string is legitimate. Never use `ValidateSet` for values controlled by a fast-changing remote service (prefer dynamic completion + runtime validation). Never call the network in `ValidateScript`. Prefer a parser/platform API over regex where safer.
- **Paths**: distinguish `Path` (provider-aware, possibly wildcard) from `LiteralPath` (exact), `Destination`, `OutputPath`. Use `[SupportsWildcards()]` only if actually supported. Do not assume all paths are filesystem paths; validate the provider for filesystem-only ops. Guard against path traversal, unintended wildcard expansion, symlink surprises, TOCTOU races, unsafe temp locations, silent overwrite.
- **Credentials/auth**: `[PSCredential]` for username/password flows genuinely required; never accept a separate plaintext password parameter. Convert `SecureString` to plaintext only at a narrow external boundary, minimizing lifetime. Prefer token/certificate/managed-identity/delegated auth where appropriate. `SecureString` is not encryption-at-rest by itself.
- **Cancellation/timeout**: network and long-running operations must expose explicit timeout behavior; binary async ops should support cancellation; script modules should offer timeout params or cancellation-aware polling. Never poll indefinitely without a user-controlled timeout.

## Pipeline semantics
Support pipeline input only when it creates a natural composition model. Use `ValueFromPipeline` when the whole incoming object is the parameter value; `ValueFromPipelineByPropertyName` when standard/domain property names map predictably. Do not enable both mechanically. Use aliases for property binding only for stable, well-known names:
```powershell
[Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
[Alias('Id')]
[ValidateNotNullOrEmpty()]
[string]
$WidgetId
```
Process each item independently unless explicitly batch-oriented. For per-item failure: decide whether processing continues; use non-terminating errors for recoverable per-item failures, terminating for invalid command-wide state; preserve input identity in errors. Do not accumulate the whole pipeline in memory unless batching/global analysis requires it; if batching helps a remote API, expose and document it without breaking pipeline expectations.

## ShouldProcess, confirmation, destructive actions
Any command that changes external state (create/modify/remove/publish/install/uninstall/connect-with-persistence/grant-revoke/start-stop/overwrite/update-config) must support `ShouldProcess`.

```powershell
[CmdletBinding(SupportsShouldProcess)]
param(...)

if ($PSCmdlet.ShouldProcess($Target, $Action)) {
    # Perform the mutation
}
```
Declaring support without calling it, or calling it without declaring support, are both incorrect. Target/action text: specific, concise, free of secrets, understandable before execution. Place the check close to the actual mutation, avoiding duplicate prompts for one logical operation. For multi-object commands, deliberately choose per-object / per-batch / once-for-the-operation confirmation and document it.

Never hand-implement `-WhatIf`. Never call `ShouldProcess` on a read-only command. Use `ConfirmImpact = 'High'` only for unusually destructive/hard-to-reverse operations; do not add `Medium` without reason (it is normally the default). Use `ShouldContinue` only for an additional exceptional warning that confirmation cannot represent. `-Force` must bypass only the extra `ShouldContinue` prompt, never `ShouldProcess`, and never authorization/validation/security controls.
