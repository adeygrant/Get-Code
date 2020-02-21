function Get-BitlockerRecoveryInfo{
    <#
        .Synopsis
        Gets Bitlocker recovery key.
        .Description
        Gets the latest Bitlocker recovery information for
        a given machine name. Outputs only the latest key.
        .Example
        Get-BitlockerRecoveryInfo -name 'PC1-TEST'
        'PC1-TEST', 'PC2-TEST' | Get-BitlockerRecoveryInfo
        Get-BitlockerRecoveryInfo -name 'PC1-TEST', 'PC2-TEST'
        .Notes
        Need domain admin rights to view bitlocker info.
        Can use | clip to add to clipboard rather than output.
        Or even | Out-Printer...
        Accepts a array of strings also...
    #>
    [cmdletbinding()]

    Param(
        # This parameter specifies the name of the machine. Can be piped. Or a string array.
        [Parameter(
            Mandatory         = $true,
            ValueFromPipeline = $true)]
        [string[]]$name
    )

        begin {

            Write-Verbose "[ BEGIN ] Getting elevated priviledges..."
            $cred = Get-Credential

        }

        process {

            $name | ForEach-Object {
                $computer = $_

                    Write-Verbose "[PROCESS] Getting AD Computer object for $computer..."
                    $computer = Get-ADComputer -Identity $computer

                    Write-Verbose "[PROCESS] Getting recovery password and selecting most recent..."
                    $adObject = Get-ADObject -SearchBase $computer.distinguishedName -Filter {ObjectClass -eq 'msFVE-RecoveryInformation'} -Properties 'msFVE-RecoveryPassword' `
                                -cred $cred | Sort-Object Name -Descending | Select-Object -first 1

                    Write-Verbose "[PROCESS] Define custom object..."
                    $obj =  [PSCustomObject]@{
                            Computer   = $computer.Name
                            RecoveryId = $adObject.Name.Split('{}')[1]
                            RecoveryPw = $adObject.'msFVE-RecoveryPassword'
                            Date       = $adObject.Name.Split('{}')[0]
                            }

                    Write-Verbose "[PROCESS] Output and format list..."
                    $obj | Format-List
            
            }
        }

        end {

            Write-Verbose "[  END  ] Any cleanup to do?"

        }
}
