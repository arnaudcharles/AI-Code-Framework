BeforeAll {
    $ModuleRoot = Split-Path -Parent $PSScriptRoot | Split-Path -Parent
    $ManifestPath = Join-Path -Path $ModuleRoot -ChildPath 'src/ModuleName/ModuleName.psd1'
    Import-Module -Name $ManifestPath -Force
}

AfterAll {
    Remove-Module -Name 'ModuleName' -ErrorAction SilentlyContinue
}

Describe 'Get-ModuleNameWidget' {
    It 'returns a WidgetInfo object for a valid name' {
        $Result = Get-ModuleNameWidget -Name 'demo'

        $Result.PSTypeNames | Should -Contain 'ModuleName.WidgetInfo'
        $Result.Name | Should -Be 'demo'
    }

    It 'rejects an empty name' {
        { Get-ModuleNameWidget -Name '' } | Should -Throw
    }

    It 'binds Name from pipeline by property name' {
        $Result = [pscustomobject]@{ Name = 'piped' } | Get-ModuleNameWidget

        $Result.Name | Should -Be 'piped'
    }
}
