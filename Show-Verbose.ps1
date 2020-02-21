<#
.SYNOPSIS
Basic example of verbose messages.
.DESCRIPTION
Super basic demo of verbose messages. 
Good for showing a decent example of how to 
output them to the console.
.EXAMPLE
.\Show-Verbose.ps1 -test "thisisastring"
.EXAMPLE
.\Show-Verbose.ps1 -test "thisisastring" -verbose
.NOTES
#######################################
sample notes
#######################################
#>

[cmdletbinding()]

    Param
        (
        [Parameter(Mandatory = $true)]
        [string] $test
        )

        begin {

            Write-Verbose -Message "[ BEGIN ] This is a verbose message from the begin block."
        }#begin
        process{
            Write-Verbose -Message "[PROCESS] This is a verbose message from the process block."
            Write-Host "Test is: $test"
        }#process
        end{
            Write-Verbose -Message "[  END  ] This is a verbose message from the end block."
        }#end
