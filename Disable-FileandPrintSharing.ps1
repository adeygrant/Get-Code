<#
.SYNOPSIS
Disables file and printer sharing.
.DESCRIPTION
Disables File and printer sharing from the adapter
and the 'Advanced sharing settings' in contorl panel.
.EXAMPLE
.\Disable-FileandPrintSharing.ps1
.NOTES
sample notes
.LINK
Link1 - https://docs.microsoft.com/en-us/powershell/module/netadapter/get-netadapterbinding?view=win10-ps
Link2 - https://docs.microsoft.com/en-us/windows/desktop/api/ifdef/ns-ifdef-_net_luid_lh
#>

Function Disable-FileandPrintSharing{

    # get the current adapter
    $adapter = Get-NetAdapter -Physical | Where-Object -Property Status -eq "Up" | Where-Object -Property InterfaceType -eq "6"

    # disbale file and printer sharing on the adapter.
    Disable-NetAdapterBinding -Name $adapter.Name -ComponentID ms_server

    # disables file and printer sharing from 'Advanced sharing settings' in control panel.
    Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled False -Profile Any
        
}# end Disable-FileandPrintSharing

Disable-FileandPrintSharing