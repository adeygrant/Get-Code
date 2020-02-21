<#
.SYNOPSIS
Get OS information
.DESCRIPTION
Gets Windows OS information utilising Win32_operating_system class. 
See notes for full class documentation. 
.EXAMPLE
Get-OSInfo -Caption -BuildNumber
.NOTES
#######################################
https://msdn.microsoft.com/en-us/library/aa394239(v=vs.85).aspx
NB: Doesn't hold the position which the params are passed...
Would be nice to fix tbh.
#######################################
.LINK
https://github.com/adeygrant/ 
#>
function Get-OSInfo {
        
    Param
        (
        [AllowNull()]
        [switch] $caption,
        [AllowNull()]
        [switch] $osarchitecture,
        [AllowNull()]
        [switch] $version,
        [AllowNull()]
        [switch] $buildnumber
        )

        if($caption)        { (Get-WmiObject -class Win32_OperatingSystem).caption }
        if($osarchitecture) { (Get-WmiObject -class Win32_OperatingSystem).osarchitecture }
        if($version)        { (Get-WmiObject -class Win32_OperatingSystem).version }
        if($buildnumber)    { (Get-WmiObject -class Win32_OperatingSystem).buildnumber }

        }

Clear-Host
Set-Location C:\temp
Get-OSInfo -osarchitecture -caption
