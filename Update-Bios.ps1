function Update-Bios {
    <#
        .Synopsis
        This script updates the BIOS for Dell & HP machines.
        .Description
        Check list / switch for models supported.
        .Example
        Update-Bios
        .Notes
        To be used alongside a copy file task - C:\temp\HPBiosUpdate\HpqFlash.exe
        To be used alongside a copy file task - C:\temp\HPBiosUpdate\HPBIOSUPDREC64.exe
        Also a copy file task of all the update files into C:\temp\BiosUpdate\.
        Some are .cab files, others are .bin files. The dell ones are just .exe
        Dell exit codes;
        https://topics-cdn.dell.com/pdf/dell-update-packages-v15.06.201_users-guide_en-us.pdf
        .Link
        alink.com
    #>
    [CmdletBinding()]

    $FilePath = "C:\temp\BiosUpdate"

    $model = (Get-WmiObject -Class Win32_ComputerSystem).Model
    
    function HpqFlash([string]$biosFile, [string]$model){
        Write-Host "updating bios using HpqFlash.exe on $model. Required bios file: $biosFile."
        
        $switches  = " -s -a -f$FilePath\$biosFile"
        $flashbios = Start-Process -FilePath $FilePath\HpqFlash.exe -ArgumentList $switches -PassThru -Wait
        
        switch ($flashbios.ExitCode) {
            1602 { Write-Host "FAILURE:NOREBOOT=The install cannot complete due to a dependency." ; Exit 101 }
            3010 { Write-Host "SUCCESS:REBOOT=A restart is required to complete the install." ;     Exit 0   }
        Default  { Write-Host "Something went wrong. Exiting." ;                                    Exit 101 }
        }

    }
    
    function HPBIOSUPDREC64([string]$biosFile, [string]$model){
        Write-Host "updating bios using HPBIOSUPDREC64.exe on $model. Required bios file: $biosFile."
        
        $switches  = " -s -a -r -f $filePath\$biosFile"
        $flashbios = Start-Process -FilePath $FilePath\HPBIOSUPDREC64.exe -ArgumentList $switches -Passthru -Wait

        switch ($flashbios.ExitCode) {
            3010 { Write-Host "SUCCESS:REBOOT=A restart is required to complete the install." ;                                                 Exit 0    }
            1602 { Write-Host "FAILURE:NOREBOOT=The install cannot complete due to a dependency." ;                                             Exit 1062 }
            282  { Write-Host "CANCEL:NOREBOOT=Flash failed due to update is the same version as the current BIOS." ;                           Exit 0    }
            273  { Write-Host "FAILURE:NOREBOOT=Flash failed due to update is older than the current BIOS and -a override flag was not used." ; Exit 0    }
            259  { Write-Host "FAILURE:NOREBOOT=Returned due to internal failure" ;                                                             Exit 259  }
            3011 { Write-Host "CANCEL:NOREBOOT=Rollback successful and previous flash preparation removed. A reboot is required." ;             Exit 3011 }
            3012 { Write-Host "FAILURE:NOREBOOT=Rollback failed and previous flash preparation removal failed." ;                               Exit 3012 }
            290  { Write-Host "CANCEL:NOREBOOT=Bitlocker is enabled and utility is running in silent mode." ;                                   Exit 290  }
            128  { Write-Host "CANCEL:NOREBOOT=Setup password does not match, or unable to read password file." ;                               Exit 128  }
        Default  { Write-Host "Something went wrong. Exiting." ;                                                                                Exit 101  }
        }

    }

    function DellBiosUpdate([string]$biosFile, [string]$model){
        Write-Host "updating dell bios on $model. Required BIOS file: $biosFile."
        
        $switches  = " /s"
        $flashbios = Start-Process -FilePath $FilePath\$biosFile -ArgumentList $switches -PassThru -Wait
        
        switch ($flashbios.ExitCode){
            0   { Write-Host "Success: The update was successful." ;                                                       Exit 0   }
            1   { Write-Host "Unsuccessful: An error occurred during the update process; the update was not successful." ; Exit 1   }
            2   { Write-Host "Success: You must restart the system to apply the updates." ;                                Exit 0   }
            3   { Write-Host "Soft dependency error: Same version of BIOS or downgrading." ;                               Exit 3   }
            4   { Write-Host "Hard dependency error: Prerequisites not found." ;                                           Exit 4   }
            5   { Write-Host "Qualification error: Not supported / compatible." ;                                          Exit 5   }
            6   { Write-Host "Rebooting system: The system is being rebooted." ;                                           Exit 6   }
            13  { Write-Host "Update is successful. Soft Dependencies are not met." ;                                      Exit 13  }
            14  { Write-Host "Update is successful. Soft Dependencies are not met. Reboot required." ;                     Exit 14  }
        Default { "Something went wrong. Exiting." ;                                                                       Exit 101 }
        }

    }

    switch ($model) {
        "HP EliteDesk 800 G1 DM"                   { HpqFlash -biosFile "L04_0231.cab" -model $model }
        "HP EliteDesk 800 G1 SFF"                  { HpqFlash -biosFile "L01_0275.cab" -model $model }
        "HP EliteDesk 800 G1 TWR"                  { HpqFlash -biosFile "L01_0275.cab" -model $model }
        "HP EliteDesk 800 G1 USDT"                 { HpqFlash -biosFile "L01_0275.cab" -model $model }
        "HP EliteOne 800 G1 AiO"                   { HpqFlash -biosFile "L01_0275.cab" -model $model }
        "HP EliteOne 800 G1 Touch AiO"             { HpqFlash -biosFile "L01_0275.cab" -model $model }
                
        "HP EliteDesk 800 G2 DM 65W"               { HPBIOSUPDREC64 -biosFile "N21_0235.bin" -model $model }
        "HP EliteDesk 800 G2 SFF"                  { HPBIOSUPDREC64 -biosFile "N01_0237.bin" -model $model }
        "HP EliteDesk 800 G2 TWR"                  { HPBIOSUPDREC64 -biosFile "N01_0237.bin" -model $model }
        "HP EliteDesk 800 G2 AiO"                  { HPBIOSUPDREC64 -biosFile "N11_0230.bin" -model $model }
        "HP EliteOne 800 G2 23-in Touch AiO"       { HPBIOSUPDREC64 -biosFile "N11_0230.bin" -model $model }
        "HP EliteOne 800 G2 23-in Non-Touch AiO"   { HPBIOSUPDREC64 -biosFile "N11_0230.bin" -model $model }
        "HP EliteOne 800 G2 23-in NT GPU AiO"      { HPBIOSUPDREC64 -biosFile "N11_0230.bin" -model $model }
        
        "HP EliteDesk 800 G3 DM 65W"               { HPBIOSUPDREC64 -biosFile "P21_0222.bin" -model $model }
        "HP EliteDesk 800 G3 SFF"                  { HPBIOSUPDREC64 -biosFile "P01_0222.bin" -model $model }
        "HP EliteDesk 800 G3 TWR"                  { HPBIOSUPDREC64 -biosFile "P01_0222.bin" -model $model }
        "HP EliteOne 800 G3 23.8-in Non-Touch AiO" { HPBIOSUPDREC64 -biosFile "P11_0222.bin" -model $model }

        "OptiPlex 980"                             { DellBiosUpdate -biosFile "O980-A18.EXE" -model $model }
        "OptiPlex 990"                             { DellBiosUpdate -biosFile "O990-A24.exe" -model $model }
        "OptiPlex 7010"                            { DellBiosUpdate -biosFile "O7010A29.exe" -model $model }
        "OptiPlex 7020"                            { DellBiosUpdate -biosFile "O7020A17.exe" -model $model }
        "OptiPlex 9010"                            { DellBiosUpdate -biosFile "O9010A30.exe" -model $model }
        "OptiPlex 9020"                            { DellBiosUpdate -biosFile "O9020A24.exe" -model $model }
        Default { "Not a supported model. Exiting..."
        Exit 101 }
    }

}

Update-Bios
