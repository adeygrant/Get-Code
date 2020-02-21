<#
.SYNOPSIS
Enables or disables the nic powersaving.
.DESCRIPTION
Setting 'Allow the computer to turn off this device to save power'
in device manager. Gets all physical ethernet adapters and applies the setting.
Does not apply the setting to wireless adapters...
.EXAMPLE
.\Set-Nicpower -enable
.EXAMPLE
.\Set-Nicpower -disable
.NOTES
I tried using Set-NetAdapterPowerManagement but it looks it is for something else.
I think the settings the adapter supports is different from how Windows handles it?
The script will fail if there are two physical ethernet ports...Could put a loop in if needed.
.LINK
Link1 - https://docs.microsoft.com/en-us/windows/desktop/api/ifdef/ns-ifdef-_net_luid_lh
Link2 - https://stackoverflow.com/questions/46145449/disable-turn-off-this-device-to-save-power-for-nic
#>

[cmdletbinding()]

    Param
        (
        [Parameter(Mandatory = $false,ParameterSetName = "enable")]
        [switch]$enable,
        [Parameter(Mandatory = $false,ParameterSetName = "disable")]
        [switch]$disable)

           
                # the interface types are paired to values. 6 is ethernet. 71 is wifi. See Link1.
                $adapter = Get-NetAdapter -Physical | Where-Object -Property Status -eq "Up" | Where-Object -Property InterfaceType -eq "6"
                
                switch ($PSCmdlet.ParameterSetName) {
                    enable  {   Write-Host "Enabling power saving on the nic."
                                # the [regex]::escape tells PS to use the backslahes literally as the PNPDeviceID/InstanceName contain slashes. i.e. PCI\VEN_8086&DEV_15B7&SUBSYS
                                $nicPower = Get-WmiObject -Class MSPower_DeviceEnable -Namespace root\wmi | Where-Object {$_.InstanceName -match [regex]::escape($adapter.PNPDeviceID) }
                                $nicPower.Enable = $true
                                $nicPower.psbase.Put() | Out-Null

                                    if($nicPower.Enable -eq $true){
                                        Write-Host "Success."
                                        Exit 0 
                                    }# end if
                                    else{
                                        Write-Host "Failed. Something went wrong."
                                        Exit 101
                                    }# end else
                            }# end enable
                                
                    disable {   Write-Host "Disabling power saving on the nic." 
                                $nicPower = Get-WmiObject -Class MSPower_DeviceEnable -Namespace root\wmi | Where-Object {$_.InstanceName -match [regex]::escape($adapter.PNPDeviceID) }
                                $nicPower.Enable = $false
                                $nicPower.psbase.Put() | Out-Null

                                    if($nicPower.Enable -eq $false){
                                        Write-Host "Success."
                                        Exit 0 
                                    }# end if
                                    else{
                                        Write-Host "Failed. Something went wrong."
                                        Exit 101
                                    }# end else
                            }# end disable
                }# end switch           