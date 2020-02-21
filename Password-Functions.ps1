function New-Password {
    <#
        .Synopsis
        Generates a random password.
        .Description
        Generates a random password using [CHAR]
        and the ASCII table. See comments.
        .Example
        New-Password -length 10
        New-Password -length 10 -symbols
        New-Password -length 10 -passwords 15
        15 | New-Password
        .Notes
        Default length is 10.
        Uses ASCII table.
    #>
    [cmdletbinding()]
    Param
        (
        # Number of passwords to generate
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [int]$passwords = 1,
        # Validates password length between 10-61
        [Parameter(Mandatory = $false)]
        [ValidateRange(10,61)]
        [int]$length = 10,
        # Switch parameter to include symbols
        [Parameter(Mandatory = $false)]
        [switch]$symbols)

        begin {
            # Can't we make this section better?
            if ($symbols){
                # AZaz09 !"#$%&'()*+,-./
                $CharacterSet = (65..90) + (97..122) + (48..57) + (33..47)
            }
            else {
                # AZaz09
                $CharacterSet = (65..90) + (97..122) + (48..57)
            }
        }

        process{
            1..$passwords | ForEach-Object {

                1..$length | ForEach-Object { 
                    $password += [CHAR]($CharacterSet | Get-Random)
                }
            
                Write-Host $password
                Clear-Variable -Name 'password'
            }

            
        }

        end{
            Write-Verbose "$passwords passwords generated with a length of $length characters."
        }

}
# Do we need to return the password var so you can | Out-File C:\....txt?
# Change the symbols to something more common. & add them to param description as a comment.
14 | New-Password

function New-Password {
    <#
        .Synopsis
        Generates a random password.
        .Description
        Generates a random password using [CHAR]
        and the ASCII table. See comments.
        .Example
        New-Password -length 10
        .Notes
        Default length is 10.
        Uses ASCII table.
    #>
    [cmdletbinding()]
    Param
        (
        # Validates password length between 10-61
        [Parameter(Mandatory = $false)]
        [ValidateRange(10,61)]
        [int]$length = 10)

    # AZaz09
    $CharacterSet = (65..90) + (97..122) + (48..57)

    $password = @()

    ForEach($number in 1..$length){
        $value = $CharacterSet | Get-Random
        $password += [char]$value
        
    }
    
    -join $password

}

New-Password -length 10

<#
.SYNOPSIS
Generates a random password.
.DESCRIPTION
Generates a random password using [CHAR]
and the ASCII table. See comments.
.EXAMPLE
New-Password -length 10
.EXAMPLE
New-Password
.EXAMPLE
New-Password -length 15 | Clip
.NOTES
problem is this password won't contain duplicates. 
so the complete length is 26*2 for upper and lower.
default length is 10
#>
function New-Password {

[cmdletbinding()]

    Param
        (
        #validates password length between 8-128
        #add a default value of 10
        [Parameter(Mandatory = $false)]
        [ValidateRange(8,52)]
        [int]$length = 10)

            begin {
                #65-90 in ascii table is UPPERCASE alphabet. 97-122 is lower. This combines two ranges.
                $alphabet = (65..90) + (97..122)
                
            }#end begin

            process {
                #create an array of numbers
                $numbers = $alphabet | Get-Random -Count $length
                #empty array
                $password = @()
                
                #loop through the array of numbers
                $numbers | ForEach-Object {
                    #add each corresponding ASCII char to the new array
                    $password += [CHAR]$_
                }

                #join each char to create the pw
                -join $password

            }#end process

            end {

            }#end end
}#end New-Password

<#
.SYNOPSIS
Generates a random password.
.DESCRIPTION
Generates a random password using [CHAR]
and the ASCII table. See comments.
.EXAMPLE
New-Password -length 10
.NOTES
default length is 10.
#>
function New-Password {

[cmdletbinding()]

    Param
        (
        #validates password length between 8-128
        #add a default value of 10
        [Parameter(Mandatory = $false)]
        [ValidateRange(8,42)]
        [int]$length = 10)

            begin {
                #65-90 in ascii table is UPPERCASE alphabet. 97-122 is lower. This combines two ranges.
                $alphabet = (65..90) + (97..122)
                
            }#end begin

            process {
                #create an array of numbers. this is in a loop because if you send Get-Random the 
                #-Count flag and pass it $length, it takes items from the array but won't do duplicates.
                #this way it compiles $length individual calls of $alphabet | Get-Random so duplicates will be present.
                $numbers = @()
                for ($i = 1; $i -le $length; $i++){
                
                $temp = $alphabet | Get-Random
                $numbers += $temp
                
                }#end for loop

                #loop through the array of numbers
                #can we do this without creating $password?
                $numbers | ForEach-Object {

                    #add each corresponding ASCII char to an array $password
                    $password += [CHAR]$_

                }#end foreach
                

            }#end process

            end {

                return $password

            }#end end
}#end New-Password
