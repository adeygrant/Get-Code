<#
.SYNOPSIS
Get computer information.
.DESCRIPTION
Get comp number using the Win32_ComputerSystem class.
See notes for full class documentation. 
.EXAMPLE
Get-CompInfo -manufacturer -model
.EXAMPLE
Get-CompInfo -domain -manufacturer
.NOTES
https://msdn.microsoft.com/en-us/library/aa394102(v=vs.85).aspx
Keeps the order in which the params are passed.
$PSBoundParameters is a hash table containing pairs, key and value.
GetEnumerator expands this table. Looping through each key pair 
& running the command needed.
#######################################
.LINK
https://github.com/adeygrant/ 
#>
function Get-CompInfo {
        
    Param
        (
        [switch] $manufacturer,
        [switch] $model,
        [switch] $domain,
        [switch] $dnshostname
        )

        foreach ($psbp in $PSBoundParameters.GetEnumerator()){
        
        $cmd = "(Get-WmiObject -Class Win32_ComputerSystem)." + $psbp.Key
        Invoke-Expression -Command $cmd
        }

        }

Clear-Host
Set-Location C:\temp
Get-CompInfo -model -manufacturer -dnshostname -domain
