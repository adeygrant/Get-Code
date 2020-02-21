function Get-StringHash{
    <#
        .Synopsis
        Creates MD5 hash for string input
        .Example
        Get-StringHash -string 'thisisatest'
        $string | Get-StringHash
        .Notes
        # Need to adapt it so it accepts different types of algorithm.
    #>
    [CmdletBinding()]
    Param(
    # String input
    [Parameter(Mandatory = $true, ValueFromPipeLine = $true)]
    [string]$string,
    # Specifies MD5 hash
    [Parameter(Mandatory = $false)]
    [ValidateSet('MD5', 'SHA1')]
    [string]$algorithm = 'MD5'
    )

    begin{
        Write-Output "Selected algorithm: $algorithm."

        $md5  = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
        $utf8 = New-Object -TypeName System.Text.UTF8Encoding

    }
    process{

        $hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($string)))
        $hash.Replace('-', '').ToLower()
        
    }
    end{

    }

}

$string = 'abcdef609043'
$anotherstring = 'pqrstuv1048970'
$string, $anotherstring | Get-StringHash
