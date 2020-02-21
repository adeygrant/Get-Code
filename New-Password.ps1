<#
    .Synopsis
    Generates a random password.
    .Description
    Generates a random password using [CHAR]
    and the ASCII table. See comments.
    Default password uses AZaz09.
    .Example
    .\New-Password -length 10
    .\New-Password -length 15 -symbols
    1..15 | Foreach-Object { .\New-Password.ps1 -length 10 }
    .Notes
    33..47   = !"#$%&'()*+,-./
    48..57   = 0123456789
    58..64   = :;<=>?@
    65..90   = A-Z
    91..95   = [\]^_
    97..122  = a-z
    123..126 = {|}~
#>
[cmdletbinding(DefaultParameterSetName = 'AZaz09')]
Param
    (
    # Validates password length between 10-61. Default length is 10.
    [Parameter(Mandatory = $false)]
    [ValidateRange(10,61)]
    [int]$length = 10,
    # Switch parameter to include AZaz09
    [Parameter(Mandatory = $false, ParameterSetName = 'AZaz09')]
    [switch]$AZaz09,
    # Switch parameter to include standard symbols !"#$%&'()*+,-./
    [Parameter(Mandatory = $false, ParameterSetName = 'symbols')]
    [switch]$symbols,
    # Switch parameter to include extended symbols !"#$%&'()*+,-./:;<=>?@[\]^_{|}~
    [Parameter(Mandatory = $false, ParameterSetName = 'extendedsymbols')]
    [switch]$extendedsymbols)

    begin {
        
        switch ($PSCmdlet.ParameterSetName){
            'AZaz09'          { $CharacterSet = (65..90) + (97..122) + (48..57) }
            'symbols'         { $CharacterSet = (65..90) + (97..122) + (48..57) + (33..47) }
            'extendedsymbols' { $CharacterSet = (65..90) + (97..122) + (48..57) + (33..47) + (58..64) + (91..95) + (123..126) }
        }
    }

    process {

            1..$length | ForEach-Object { 
                $password += [CHAR]($CharacterSet | Get-Random)
            }
            
            Write-Host $password
    }

    end {
        
    }
