<#
.SYNOPSIS
Gives user access to folder.
.DESCRIPTION
Gives specified user modify or full access to a folder.
.EXAMPLE
.\Set-Perms.ps1 -path "C:\temp" -user "abc12" -m
.NOTES
#######################################
Good example of simple parameter validation.
Also good script format as opposed to function.
Need to look into doing this again but providing
custom error messages. i.e. learning try catch
and throw and trap stuff.
#######################################
.LINK
https://github.com/adeygrant/ 
#>

[cmdletbinding()]

    Param
        (
        # Validates the path is a container
        [Parameter(Mandatory = $true)]
        [ValidateScript({Test-Path $_ -PathType 'Container'})]
        [string] $path,
        # Validates a 5 character alphanumeric string
        [Parameter(Mandatory = $true)]
        [ValidateLength(5,5)]
        [ValidatePattern("^[a-zA-Z0-9]*$")]
        [string] $user,
        
        [Parameter(Mandatory = $true, ParameterSetName = "full")]
        [switch] $f,
        [Parameter(Mandatory = $true, ParameterSetName = "modify")]
        [switch] $m
        )

        $path = $PSBoundParameters["path"]
        $user = $PSBoundParameters["user"]
        
        if($m){ $access = "M"}
        else { $access = "F"}
        
        $cmd = "C:\Windows\System32\icacls.exe " + $path + " /grant " + $user + ":(OI)(CI)" + $access
       
        #not actually tested the command
        #worth having a go using invoke-command or something
        Write-Output $cmd

        
