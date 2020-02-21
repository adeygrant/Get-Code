function Set-LenovoBios {
    <#
        .Description
        Applies settings to Lenovo Bios from the OS.
        Can pass it a list of settings to be changed.
        One of the problems we've found is that you cannot change the SecureBoot setting - It requires
        confirmation / authorisation so you can't change it using this script.
        Use the commands in the notes to build the settings list - Not all BIOS' share the same settings.
        eg. a desktop won't have options to enable/disable the trackpad etc. You can try to apply a setting
        that doesn't exist - You should receive the correct error message. It will continue to process the other settings
        if one fails so you can have some overlap between devices.
        .Notes
        Useful commands to build settings list;
        Get all current settings:  Get-WmiObject -Class Lenovo_BiosSetting -Namespace root\wmi | Select-Object -Property CurrentSetting
        Get setting based on name: Get-WmiObject -Class Lenovo_BiosSetting -Namespace root\wmi | Where-Object -Property CurrentSetting -Like "*Wake on LAN*" | Select-Object -Property CurrentSetting
        Here is a link to Lenovo documentation;
        https://download.lenovo.com/ibmdl/pub/pc/pccbbs/thinkcentre_pdf/wmi_dtdeploymentguide_m92.pdf
        I tried using securestring param for the password but it seemed to cause access denied message so
        just going to stick with basic string.
        If you don't supply a password it won't validate and will try to apply the settings with no passowrd
    #>
    [CmdletBinding()]
    Param(
        # This parameter specifies the settings to be applied. Will accept an array
        [Parameter(Mandatory = $true)]
        [string[]]
        $settings,
	    # This parameter specifies the bios administrator password
        [Parameter(Mandatory = $false)]
        [string]
        $password
    )
    
    $setBiosSetting  = Get-WmiObject -Class Lenovo_SetBiosSetting -Namespace root\wmi
    $saveBiosSetting = Get-WmiObject -Class Lenovo_SaveBiosSettings -Namespace root\wmi
    
    # loop through all settings and apply
    Write-Output "Changing settings..."
    ForEach ($setting in $settings){

        $var = $setBiosSetting.SetBiosSetting($setting)
                
        switch ($var.return){
            "Success"           { Write-Output "$setting applied successfully."              }
            "Not Supported"     { Write-Output "$setting is not supported on this system."   }
            "Invalid Parameter" { Write-Output "$setting is an invalid Bios setting."        }
            "Access Denied"     { Write-Output "Access denied. Check BIOS password / perms." }
            "System Busy"       { Write-Output "Conflicting settings. Needs system reboot."  }
            Default             { Write-Output "Something went wrong setting $setting."      }
        }
    }

    # save changes to BIOS
    if($password){
	Write-Output 'Saving changes with password...'
    	$temp = $saveBiosSetting.SaveBiosSettings("$password,ascii,us;")
    }
    else{
	Write-Output 'Saving changes without password...'
    	$temp = $saveBiosSetting.SaveBiosSettings()
    }

        switch ($temp.return) {
          'Success' 	    { Write-Output 'Success.'                           }
	        'Access Denied' { Write-Output 'Access denied. Admin Password set?' }
          Default         { Write-Output 'Something went wrong.'              }
        }   
}

$biosSettings = @(
        'Wake on LAN,Automatic;',
        'Internal Speaker,Enabled;'
)

$password = 'supersecurepassword'

Set-LenovoBios -settings $biosSettings -password $password
