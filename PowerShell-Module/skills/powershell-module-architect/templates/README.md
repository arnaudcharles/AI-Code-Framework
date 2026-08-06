# ModuleName

One-sentence description of what this module manages.

## Supported environments
PowerShell 7.4+ on Windows, Linux, macOS. See [docs/compatibility.md](docs/compatibility.md) once written, or the compatibility matrix in `AGENTS.md`'s referenced standard.

## Installation
```powershell
Install-PSResource -Name ModuleName -Repository PSGallery
```

## Quick start
```powershell
Import-Module ModuleName
Get-ModuleNameWidget -Name 'demo'
```

## Authentication
Describe here once the module has a real authentication model (see `Connect-*`/`Disconnect-*` commands if applicable).

## Common scenarios
Add real scenarios here as the module grows. Do not leave generic filler.

## Error handling
```powershell
try {
    Get-ModuleNameWidget -Name 'demo' -ErrorAction Stop
}
catch {
    Write-Warning "Widget lookup failed: $($_.Exception.Message)"
}
```

## Security considerations
See [SECURITY.md](SECURITY.md).

## Compatibility notes
See the compatibility matrix maintained alongside this module once real platform testing exists.

## Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md).

## Support policy
State the support window here once decided (e.g. current and previous major version).

## License
See [LICENSE](LICENSE).
