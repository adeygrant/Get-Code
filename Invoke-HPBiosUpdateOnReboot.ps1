function Invoke-HPBiosUpdateOnReboot{
    <#
        .Synopsis
        Updates HP Bios.
        .Description
        Invokes a HP update on next reboot.
        .Notes
        This doesn't force an update. The user can cancel / postpone the update.
    #>
    [CmdletBinding()]
    Param(
    # Specifies the bios administrator password
    [Parameter(Mandatory = $false)]
    [securestring]
    $password
    )

    $status = Get-BitLockerVolume | Select-Object -ExpandProperty 'ProtectionStatus'
        if ($status -eq 'On'){
            Write-Output 'Bitlocker is enabled. Exiting.' ; Exit 101
        }
        else{
            Write-Output 'Bitlocker off. Continue.'
        }

    $settingname  = 'Automatic BIOS Update Setting'
    $settingvalue = 'Install all updates automatically'
    
    $obj = Get-WmiObject -Class "HPBIOS_BIOSSettingInterface" -Namespace 'root\HP\InstrumentedBIOS'
    $obj.SetBiosSetting($settingname,$settingvalue,'<utf-16/>' + $password)

}

$password = ConvertTo-SecureString 'password' -asplaintext -force

Invoke-HPBiosUpdateOnReboot -password $password
