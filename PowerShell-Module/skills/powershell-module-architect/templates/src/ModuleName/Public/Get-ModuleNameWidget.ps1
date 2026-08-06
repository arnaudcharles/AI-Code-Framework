function Get-ModuleNameWidget {
    <#
    .SYNOPSIS
        Gets one or more widgets.
    .DESCRIPTION
        Retrieves widgets by name. Replace this example with a real command.
    .PARAMETER Name
        The widget name to retrieve. Supports pipeline binding by property name.
    .EXAMPLE
        Get-ModuleNameWidget -Name 'demo'
    .INPUTS
        System.String
    .OUTPUTS
        ModuleName.WidgetInfo
    .LINK
        https://example.invalid/project
    #>
    [CmdletBinding()]
    [OutputType('ModuleName.WidgetInfo')]
    param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name
    )

    process {
        $Widget = ConvertTo-ModuleNameWidgetInfo -Name $Name

        Write-Output $Widget
    }
}
