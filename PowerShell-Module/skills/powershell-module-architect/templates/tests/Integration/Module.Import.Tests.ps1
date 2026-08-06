BeforeAll {
    $ModuleRoot = Split-Path -Parent $PSScriptRoot | Split-Path -Parent
    $ManifestPath = Join-Path -Path $ModuleRoot -ChildPath 'src/ModuleName/ModuleName.psd1'
}

Describe 'Module import' {
    It 'imports without error' {
        { Import-Module -Name $ManifestPath -Force -ErrorAction Stop } | Should -Not -Throw
    }

    It 'imports side-effect-free (no files written under the repo during import)' {
        $Before = Get-ChildItem -Path (Split-Path -Parent $ManifestPath) -Recurse -File | Measure-Object | Select-Object -ExpandProperty Count
        Import-Module -Name $ManifestPath -Force
        $After = Get-ChildItem -Path (Split-Path -Parent $ManifestPath) -Recurse -File | Measure-Object | Select-Object -ExpandProperty Count

        $After | Should -Be $Before
    }

    AfterAll {
        Remove-Module -Name 'ModuleName' -ErrorAction SilentlyContinue
    }
}
