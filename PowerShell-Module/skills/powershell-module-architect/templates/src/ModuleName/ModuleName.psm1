#Requires -Version 7.4

$ErrorActionPreference = 'Stop'

$PublicPath  = Join-Path -Path $PSScriptRoot -ChildPath 'Public'
$PrivatePath = Join-Path -Path $PSScriptRoot -ChildPath 'Private'

$PublicFiles  = Get-ChildItem -Path $PublicPath -Filter '*.ps1' -File -ErrorAction SilentlyContinue | Sort-Object -Property Name
$PrivateFiles = Get-ChildItem -Path $PrivatePath -Filter '*.ps1' -File -ErrorAction SilentlyContinue | Sort-Object -Property Name

foreach ($File in @($PrivateFiles) + @($PublicFiles)) {
    try {
        . $File.FullName
    }
    catch {
        throw "Failed to load '$($File.FullName)': $($_.Exception.Message)"
    }
}

Export-ModuleMember -Function $PublicFiles.BaseName
