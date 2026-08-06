BeforeAll {
    $ModuleRoot = Split-Path -Parent $PSScriptRoot | Split-Path -Parent
    $ManifestPath = Join-Path -Path $ModuleRoot -ChildPath 'src/ModuleName/ModuleName.psd1'
    $Manifest = Test-ModuleManifest -Path $ManifestPath -ErrorAction Stop
}

Describe 'Manifest' {
    It 'is valid' {
        $Manifest | Should -Not -BeNullOrEmpty
    }

    It 'does not use wildcard exports' {
        (Get-Content -Raw -Path $ManifestPath) | Should -Not -Match "FunctionsToExport\s*=\s*'\*'"
        (Get-Content -Raw -Path $ManifestPath) | Should -Not -Match "CmdletsToExport\s*=\s*'\*'"
        (Get-Content -Raw -Path $ManifestPath) | Should -Not -Match "AliasesToExport\s*=\s*'\*'"
    }

    It 'has a stable, non-empty GUID' {
        $Manifest.Guid | Should -Not -Be ([guid]::Empty)
    }

    It 'declares no exported variables' {
        $Manifest.ExportedVariables.Count | Should -Be 0
    }
}
