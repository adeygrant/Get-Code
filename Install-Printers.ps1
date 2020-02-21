<#
    .Synopsis
    Manages printer installations and removals.
    .Description
    Installs printers using Add-Printer & Remove-Printer cmdlets.
    Accepts multiple printers.
    .Example
    Install-Printer.ps1 -printers '\\print.test.com\aprinter' -install
    Install-Printer.ps1 -printers '\\print.test.com\aprinter','\\print.test.com\anotherprinter' -remove
    Install-Printer.ps1 -printers '\\print.test.com\aprinter','\\print.test.com\anotherprinter' -install -default 'print.test.com\aprinter'
    .Notes
    Intended to be used to logon / logoff.
    Add-Printer & Remove-Printer are included with Windows 8.1 / Server 2012. Roughly PS 3.0 / 4.0 and above.
    Don't think it will work on Windows 7 machines even with PS 5.1 installed.
#>
[cmdletbinding()]
    Param
        (
        # Specifies the printer addresses
        [Parameter(Mandatory = $true)]
        [string[]]$printers,
        # Switch param to install printers
        [Parameter(Mandatory = $true, ParameterSetName = 'install')]
        [Parameter(Mandatory = $true, ParameterSetName = 'install_and_default')]
        [switch]$install,
        # Switch param to remove printers
        [Parameter(Mandatory = $true, ParameterSetName = 'remove')]
        [switch]$remove,
        # String param to specify default printer
        [Parameter(Mandatory = $true, ParameterSetName = 'install_and_default')]
        [string]$default
    )

function Write-Log($message){

    [ValidateScript({Test-Path $_})]
    $logpath = 'C:\temp\logfile.txt'
        
    Add-Content -Path $logpath -Value "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss") | $env:username | $message"    
}

function install-printer($printers){
    foreach ($address in $printers){
        Write-Log "Installing printer $address"
        try   { Add-Printer -ConnectionName $address -ErrorAction Stop }
        catch { Write-Log "Failed installing $address. $($error[0])" }
    }
}

function remove-printer($printers){
    foreach ($address in $printers){
        Write-Log "Removing printer $address"
        try   { Remove-Printer -Name $address -ErrorAction Stop }
        catch { Write-Log "Failed removing $address. $($error[0])" }
    }
}

function set-defaultprinter($default){
    Write-Log "Setting $default as the default printer..."
    $printerobj = Get-WmiObject -Class Win32_Printer | Where-Object -Property 'Name' -eq $default
    try   { $printerobj.SetDefaultPrinter() }
    catch { Write-Log "Failed setting $default as the default priner. Check printer exists." }
}

switch ($PSCmdlet.ParameterSetName){
    install             { install-printer $printers   }
    remove              { remove-printer  $printers   } 
    install_and_default { install-printer $printers
                          set-defaultprinter $default }
}
