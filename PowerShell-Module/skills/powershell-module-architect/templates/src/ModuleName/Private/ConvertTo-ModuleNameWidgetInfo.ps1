function ConvertTo-ModuleNameWidgetInfo {
    <#
    .SYNOPSIS
        Maps an internal widget representation to the module's public output model.
    #>
    [CmdletBinding()]
    [OutputType('ModuleName.WidgetInfo')]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name
    )

    [pscustomobject]@{
        PSTypeName = 'ModuleName.WidgetInfo'
        Name       = $Name
        RetrievedAt = [datetimeoffset]::UtcNow
    }
}
