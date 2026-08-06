# Authentication, Remote Clients, Configuration, Caching & Concurrency

## Authentication architecture
Separate authentication from business commands. Provide a context abstraction for remote services:
```
Connect-ContosoService
Disconnect-ContosoService
Get-ContosoContext
```
Expose these only when persistent session context is useful; otherwise accept auth material per command or through a client object. Never rely on unscoped mutable global variables - store context in module scope with controlled access. Support multiple contexts only if the use case requires it, and document thread/runspace behavior.

Connection commands should return a sanitized context object when useful - never expose raw tokens. Disconnect should drop in-memory references and release disposables where possible. Token refresh must be centralized, concurrency-safe, avoid duplicate refresh storms, preserve failure context, and never log tokens.

Prefer an identity order per project requirements, e.g.: explicit credential/token -> managed/workload identity -> certificate -> interactive delegated auth -> device-code flow -> environment-derived credential. Never silently choose an unexpected identity; expose the selected auth type in sanitized context output.

## Remote API client design
Separate transport, authentication, retry policy, pagination, serialization, API-error translation, and public command behavior. Build one central request function/client abstraction instead of duplicating REST logic. The request layer should support: method, relative/absolute URI under approved base endpoints, headers, query params, body, content type, timeout, cancellation where possible, retry policy, pagination, response deserialization, sanitized diagnostics.

Never let arbitrary user-controlled URIs receive auth headers unless the command is explicitly a general-purpose request command with strict safeguards. Use correct URI construction; never concatenate query strings without encoding.

**Pagination**: stream items when practical, detect malformed continuation links, prevent loops, allow `-Top`/`-PageSize` or equivalent when relevant, clarify global vs. per-page limits, preserve server order unless documented otherwise.

**Rate limits**: honor server metadata, bound total wait time, surface useful verbose info, make final failure clear.

**API versions**: centralize version selection, avoid scattering preview version strings, make preview use explicit, test stable and preview endpoints separately, never silently switch a stable command to a preview API.

## Configuration
Precedence (unless the project specifies otherwise): explicit parameter -> explicit context/config object -> process/session config -> user config -> machine config -> module default. Document the precedence. Never read config from many undocumented locations; loading must be side-effect-free; validate once at a clear boundary. Never expose secrets through `Get-...Configuration`. Use platform-appropriate storage locations - never assume Windows paths on Linux/macOS. Never write configuration during module import. Version the schema if persisted; provide compatible migration logic; back up or atomically replace critical config files.

## Caching
Cache only when it materially improves performance or resilience. Define: key, scope, lifetime, invalidation, max size, thread/runspace safety, sensitive-data policy. Never cache secrets in plaintext on disk. Never let stale authorization data bypass current permission checks. Expose a cache-clear operation only when users need it. Test cold- and warm-cache behavior; never let caching change public correctness semantics without documentation.

## Concurrency, jobs, runspaces
Use concurrency only when it improves a measured workload and the external system supports it. Avoid uncontrolled `ForEach-Object -Parallel` or job fan-out - provide a bounded throttle limit. Account for API throttling, ordering, thread safety, module context, credential use, cancellation, aggregate errors, partial results, cleanup. Never share non-thread-safe clients without protection; never assume module-scoped state is automatically available/safe in other runspaces.

For `-AsJob` commands: use the job abstraction only when appropriate, return a standard/well-documented job type, preserve error/progress semantics, test receiving/removing jobs, clean up resources. Never add async complexity to short operations.
