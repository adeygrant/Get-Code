function Set-HPBios {
    <#
        .Description
        Sets Bios settings
        .Example
        Set-HPBios.ps1
        Set-HPBios.ps1 -password 'supersecurepassword'
        .Notes
        Settings Legacy off & UEFI enable.
        Will help when re-imaging Win 7 machines.
        http://h20331.www2.hp.com/Hpsub/downloads/cmi_whitepaper.pdf
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [String]
        $password
    )

    $obj = Get-WmiObject -Class "HPBIOS_BIOSSettingInterface" -Namespace 'root\HP\InstrumentedBIOS'

    $settings = @{
        'Legacy Boot Options' = 'Disable'
        'UEFI Boot Options' = 'Enable'
        'Wake On LAN' = 'Boot to Normal Boot Order'
        'Configure Legacy Support and Secure Boot' = 'Legacy Support Disable and Secure Boot Disable'
    }

    foreach ($setting in $settings.GetEnumerator()){
        $settingname  = $setting.Key
        $settingvalue = $setting.Value
        
        $temp = $obj.SetBiosSetting($settingname,$settingvalue,'<utf-16/>' + $password)

        switch ($temp.Return) {
            0 { Write-Output "Attempting to set $settingname to $settingvalue.... Success" }
            1 { Write-Output "Attempting to set $settingname to $settingvalue.... Not Supported" }
            2 { Write-Output "Attempting to set $settingname to $settingvalue.... Unspecified Error" }
            3 { Write-Output "Attempting to set $settingname to $settingvalue.... Timeout" }
            4 { Write-Output "Attempting to set $settingname to $settingvalue.... Failed" }
            5 { Write-Output "Attempting to set $settingname to $settingvalue.... Invalid Parameter" }
            6 { Write-Output "Attempting to set $settingname to $settingvalue.... Access Denied" }
            Default { 'Something went wrong.' ; Exit 101 }
        }

    }
}

Set-HPBios -password 'biospassword'
