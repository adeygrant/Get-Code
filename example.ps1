<#
.SYNOPSIS
Just a short example function.
.DESCRIPTION
Simple example function inc some Get-Help stuff.
.EXAMPLE
Function-Template -String "String"
.NOTES
Sample notes
#>
function Function-Template {
    [CmdletBinding()]
        Param(
        [Parameter(Mandatory=$True,Position=1)]
        [string]$String)
    
Write-Host $String

}

Clear-Host
Set-Location C:\temp
Get-Help Function-Template -Detailed
Function-Template -String "Test String!!"
