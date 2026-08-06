BeforeAll {
    $ModuleRoot = Split-Path -Parent $PSScriptRoot | Split-Path -Parent
    $ManifestPath = Join-Path -Path $ModuleRoot -ChildPath 'src/ModuleName/ModuleName.psd1'
    Import-Module -Name $ManifestPath -Force
    $Module = Get-Module -Name 'ModuleName'
}

AfterAll {
    Remove-Module -Name 'ModuleName' -ErrorAction SilentlyContinue
}

Describe 'Public API surface' {
    It 'exports exactly the approved commands' {
        $ExpectedCommands = @('Get-ModuleNameWidget')

        $Module.ExportedCommands.Keys | Sort-Object | Should -Be ($ExpectedCommands | Sort-Object)
    }

    It 'exports no aliases' {
        $Module.ExportedAliases.Count | Should -Be 0
    }

    It 'every exported function has comment-based help' {
        foreach ($CommandName in $Module.ExportedFunctions.Keys) {
            $Help = Get-Help -Name $CommandName -Full
            $Help.Synopsis | Should -Not -BeNullOrEmpty
            ($Help.Examples.Example | Measure-Object).Count | Should -BeGreaterThan 0
        }
    }
}
