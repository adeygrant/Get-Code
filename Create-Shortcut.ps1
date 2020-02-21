<#
.SYNOPSIS
Creates a shortcut.
.DESCRIPTION
Creates a shortcut.
Uses wscript / comobject because
there isn't a native way in powershell
to create a shortcut. There is New-Item 
Symbolic link but it's different from 
a standard shortcut.
.EXAMPLE
Create-Shortcut -source "C:\temp\file.txt" -destination "C:\temp\file.lnk"
.NOTES
https://stackoverflow.com/questions/9701840/how-to-create-a-shortcut-using-powershell
also.........$shortcut.IconLocation = "C:\apath\to\an\.ico, 0"
more info https://support.microsoft.com/en-gb/help/244677/how-to-create-a-desktop-shortcut-with-the-windows-script-host
#>
function Create-Shortcut {
    [CmdletBinding()]
        Param(
        [Parameter(Mandatory=$True)]
        [ValidateScript({ Test-Path $_ })]
        [string]$source,
        [Parameter(Mandatory=$True)]
        [ValidateScript({ $_ -match ".lnk" })]
        [string]$destination)
    
        Write-Host "Creating a shortcut from $source to $destination."
    
        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut($destination)
        $Shortcut.TargetPath = $source
        $Shortcut.Save()

}

Create-Shortcut -source "C:\temp\file.txt" -destination "C:\temp\file.lnk"
