<#
.SYNOPSIS
Get-File using wget, net, or bits.
.DESCRIPTION
Get-File gets files using wget method, system.net.webclient or bits.
This is shows a good usage of parameter sets.
$URL and $OutFile are mandatory, then one of the 3 switches are needed. 
Errors if more than one switch is sent to the function. 
.EXAMPLE
Get-File -URL "www.google.co.uk"            -Outfile "C:\temp\file.html" -wget
.EXAMPLE
Get-File -URL "www.google.co.uk/file.pdf"   -Outfile "C:\temp\file.pdf" -net
.EXAMPLE
Get-File -URL "www.google.co.uk/file.pdf"   -Outfile "C:\temp\file.pdf" -bits
.NOTES
#######################################
Created by: Adrian Grant.
License: Public.
https://msdn.microsoft.com/en-us/library/aa394239(v=vs.85).aspx
.net function requires a specific file name for the URL. 
Both URL and OutFile need to be strings - So put them "inside" quotes.
wget is typically for webpages so can use google.co.uk
net and bits are proper file transfer so need file and extension specified.
#######################################
.LINK
https://github.com/adeygrant/ 
#>
function Get-File {
    [CmdletBinding()]
    Param
        (
        [Parameter(Mandatory=$true)]
        [string] $URL,
        [Parameter(Mandatory=$true)]
        [string] $Outfile,
        
        [Parameter(Mandatory=$true, ParameterSetName="wgetparamset")]
        [Parameter(Mandatory=$false, ParameterSetName="dotnetparamset")]
        [Parameter(Mandatory=$false, ParameterSetName="bitsparamset")]
        [switch] $wget,

        [Parameter(Mandatory=$false, ParameterSetName="wgetparamset")]
        [Parameter(Mandatory=$true, ParameterSetName="dotnetparamset")]
        [Parameter(Mandatory=$false, ParameterSetName="bitsparamset")]
        [switch] $net,

        [Parameter(Mandatory=$false, ParameterSetName="wgetparamset")]
        [Parameter(Mandatory=$false, ParameterSetName="dotnetparamset")]
        [Parameter(Mandatory=$true, ParameterSetName="bitsparamset")]
        [switch] $bits
        )
        
        Function wget_function {
            
            Write-Host "Starting WGET."
            Invoke-WebRequest $URL -OutFile $Outfile
            }

        Function net_function {
            
            Write-Host "Starting System.Net.WebClient."
            $client = New-Object System.Net.WebClient
            $client.DownloadFile($URL, $Outfile)
            }

        Function bits_function {
            
            Write-Host "Starting bits transfer."
            Start-BitsTransfer -Source $URL -Destination $Outfile
            }


        if($wget)   { wget_function -URL $URL -Outfile $Outfile }
        if($net)    { net_function -URL $URL -Outfile $Outfile }
        if($bits)   { bits_function -URL $URL -Outfile $Outfile }
        
}

Clear-Host
Set-Location C:\temp
Get-File -URL "http://www.keele.ac.uk/fwproxy.pac" -OutFile "C:\temp\fwproxy.pac" -bits