<#
.SYNOPSIS
Batch adds machines into AD.
.DESCRIPTION
Batch adds machines into AD. Can add dashes between the 
prefix and the number with the -dash switch. Asks for 
confirmation.
.EXAMPLE
.\Batch-AddAdComputers.ps1 PC 01 10 TEST
.EXAMPLE
.\Batch-Add.ps1 -prefix PC -start 01 -finish 10 -suffix TEST
.NOTES
prompts for AD creds.
adds machines into Staff Machines > Temp Holding Area > Single User Machines
#>

[cmdletbinding()]

    Param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$prefix,
        [Parameter(Mandatory = $true, Position = 1)]
        [int]$start,
        [Parameter(Mandatory = $true, Position = 2)]
        [int]$finish,
        [Parameter(Mandatory = $true, Position = 3)]
        [string]$suffix)

        # create a range
        $range  = $start..$finish
        # create blank array
        $computers = @()
        
        # loop through the range
        ForEach ($number in $range){
            # add each computer to the array. ToString("D2") is to add a trailing zero for 01 - 09
            $computers += $prefix + $var + $number.ToString("D2") + "-" + $suffix
        }# end foreach

        Write-Host "Adding "$computers.Length" machines to AD."
        $computers

        $response = Read-Host -Prompt "Would you like to continue? yes / no"
        switch ($response -eq "yes") {
            True    { Write-Host "Adding to AD..."
                        $cred = Get-Credential
                        foreach ($computer in $computers){
                            New-AdComputer -Name $computer -Path "OU=This,OU=Is,OU=An,DC=OU" -cred $cred
                        }
                    Exit }
            False   { Write-Host "Exiting."
                    Exit }
            Default { Write-Host "Something went wrong."
                    Exit }
        }# end switch
