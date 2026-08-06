# Output, Errors & Observability

## Output contract
Emit objects, not preformatted text, with stable property meaning. Preference order: existing native .NET/PowerShell types -> public module model classes -> `PSCustomObject` with a stable `PSTypeName` -> primitives for naturally primitive results.

```powershell
[pscustomobject]@{
    PSTypeName = 'Contoso.Widget.WidgetInfo'
    Id         = $Widget.Id
    Name       = $Widget.Name
    State      = $Widget.State
}
```
Never return a raw remote API response as the public contract unless the command explicitly promises raw output - map external models to module-owned output models to isolate consumers from upstream changes. Never mix unrelated output types on the success stream, and never write progress/diagnostics/status text to it. Use the right stream: success (data), verbose (operational detail), debug (developer diagnostics), information (intentional events), warning (actionable non-fatal), error (errors), progress (meaningful long operations). Never use `Write-Host` in reusable module implementation (an explicitly interactive/presentation command may, if documented; default commands stay automation-safe).

**PassThru**: mutating commands with normally no output may offer `-PassThru`, returning the affected object or a clearly documented result - never a different unrelated type with vs. without it.

**Enumeration**: understand automatic enumeration; use unary comma or `Write-Output -NoEnumerate` only when an array must be one object. Do not wrap results in arrays unnecessarily; stream large result sets.

**Formatting**: formatting is not data - never call `Format-Table`/`Format-List` inside data commands. Use `.format.ps1xml` only when it materially improves default display; views must reference stable type names, avoid expensive/side-effecting/network-calling script blocks, and degrade gracefully when optional properties are absent. Keep non-display properties reachable via `Select-Object`/direct access.

## Error model
Every meaningful error should answer: what failed, which target, why (when safe to disclose), whether retrying may help, what the user can do next. Use specific exception types; avoid throwing raw strings when a meaningful exception type exists.

```powershell
$Exception = [System.InvalidOperationException]::new(
    "Widget '$WidgetId' cannot be updated while it is locked."
)
$ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
    $Exception, 'ContosoWidgetLocked',
    [System.Management.Automation.ErrorCategory]::ResourceBusy, $WidgetId
)
$PSCmdlet.ThrowTerminatingError($ErrorRecord)
```
Use stable, documented fully-qualified error IDs (`Contoso.Widget.WidgetLocked`, `Contoso.Widget.AuthenticationFailed`) - never embed volatile text (like an identifier) inside the ID; carry that in the target object instead.

**Terminating vs non-terminating**: terminating when parameters/state make the whole command invalid, auth cannot be established, required config is missing, continuing could corrupt state, or a critical invariant is violated. Non-terminating when one pipeline item fails independently and the rest can safely continue. Respect `-ErrorAction`. Never catch merely to print - catch only to add context, translate an external exception into the module's error contract, perform narrow cleanup, retry safely, or preserve partial-result semantics; preserve the original exception as inner exception when rethrowing. Never expose tokens, passwords, sensitive headers, connection strings, or personal data in exception messages.

**Native commands**: avoid shell interpretation, pass arguments safely (never one unquoted command string, never `Invoke-Expression`), capture exit code and stdout/stderr deliberately, define accepted exit codes, handle encoding, include sanitized diagnostic context, test paths with spaces/special characters.

## Logging and observability
Native streams are the baseline - do not impose a logging framework on all consumers without justification.
- **Verbose**: significant stages, selected target/endpoint, retry attempts, cache decisions, pagination progress, compatibility fallback. Not one message per trivial assignment.
- **Debug**: deeper implementation detail, still never secrets.
- **Information**: structured, machine-consumable events with meaningful tags when appropriate.
- **Structured logging adapter**: optional boundary if enterprise logging is required. Never make PSFramework (or any framework) a mandatory dependency without a justified benefit and lifecycle assessment. Structured events include event name, timestamp, operation id, target id, duration, outcome, retry count, sanitized error classification - never access/refresh tokens, passwords, secrets, full auth headers, sensitive bodies, unnecessary personal data.
- **Correlation**: generate/accept a correlation identifier for multi-step operations and expose it in diagnostics where useful - it is not a substitute for actionable errors.
