@{
    RootModule           = 'ModuleName.psm1'
    ModuleVersion        = '0.1.0'
    GUID                 = '00000000-0000-0000-0000-000000000000' # generate once with New-Guid, never regenerate on release
    Author               = 'Your Name'
    CompanyName          = 'Unknown'
    Copyright            = '(c) Your Name. All rights reserved.'
    Description          = 'One-sentence description of what this module manages.'
    PowerShellVersion    = '7.4'
    CompatiblePSEditions = @('Core')

    FunctionsToExport    = @(
        'Get-ModuleNameWidget'
    )
    CmdletsToExport      = @()
    VariablesToExport    = @()
    AliasesToExport      = @()

    PrivateData = @{
        PSData = @{
            Tags         = @('Automation')
            LicenseUri   = 'https://example.invalid/license'
            ProjectUri   = 'https://example.invalid/project'
            ReleaseNotes = 'Initial prerelease.'
            Prerelease   = 'preview.1'
        }
    }
}
