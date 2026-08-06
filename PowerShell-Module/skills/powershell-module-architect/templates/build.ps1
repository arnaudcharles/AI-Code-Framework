#Requires -Version 7.4
#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.5.0' }, PSScriptAnalyzer

[CmdletBinding()]
param(
    [ValidateSet('Clean', 'Analyze', 'Test', 'BuildModule', 'Package', 'All')]
    [string]
    $Task = 'All'
)

$ErrorActionPreference = 'Stop'

$RepoRoot     = $PSScriptRoot
$SourcePath   = Join-Path -Path $RepoRoot -ChildPath 'src/ModuleName'
$TestsPath    = Join-Path -Path $RepoRoot -ChildPath 'tests'
$OutputPath   = Join-Path -Path $RepoRoot -ChildPath 'output'
$AnalyzerSettings = Join-Path -Path $RepoRoot -ChildPath '.config/powershell/PSScriptAnalyzerSettings.psd1'

function Invoke-Clean {
    if (Test-Path -Path $OutputPath) {
        Remove-Item -Path $OutputPath -Recurse -Force
    }
}

function Invoke-Analyze {
    $Results = Invoke-ScriptAnalyzer -Path $SourcePath -Recurse -Settings $AnalyzerSettings
    $Results | Format-Table -AutoSize

    if ($Results | Where-Object Severity -EQ 'Error') {
        throw 'PSScriptAnalyzer reported errors.'
    }
}

function Invoke-UnitTests {
    $Config = New-PesterConfiguration
    $Config.Run.Path = $TestsPath
    $Config.Run.Exit = $true
    $Config.Output.Verbosity = 'Detailed'
    $Config.CodeCoverage.Enabled = $true
    $Config.CodeCoverage.Path = "$SourcePath/**/*.ps1"
    $Config.CodeCoverage.OutputPath = Join-Path -Path $OutputPath -ChildPath 'coverage.xml'

    New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
    Invoke-Pester -Configuration $Config
}

function Invoke-BuildModule {
    $Manifest = Test-ModuleManifest -Path (Join-Path -Path $SourcePath -ChildPath 'ModuleName.psd1')
    $Version = $Manifest.Version.ToString()
    $StagingPath = Join-Path -Path $OutputPath -ChildPath "ModuleName/$Version"

    New-Item -ItemType Directory -Path $StagingPath -Force | Out-Null
    Copy-Item -Path "$SourcePath/*" -Destination $StagingPath -Recurse -Force

    return $StagingPath
}

function Invoke-Package {
    $StagingPath = Invoke-BuildModule
    $ManifestInStaging = Join-Path -Path $StagingPath -ChildPath 'ModuleName.psd1'

    # Validate the artifact from the packaged path, not from src/.
    Import-Module -Name $ManifestInStaging -Force
    Remove-Module -Name 'ModuleName' -ErrorAction SilentlyContinue

    Write-Host "Package staged at: $StagingPath"
}

switch ($Task) {
    'Clean'       { Invoke-Clean }
    'Analyze'     { Invoke-Analyze }
    'Test'        { Invoke-UnitTests }
    'BuildModule' { Invoke-BuildModule | Out-Null }
    'Package'     { Invoke-Package }
    'All' {
        Invoke-Clean
        Invoke-Analyze
        Invoke-UnitTests
        Invoke-Package
    }
}
