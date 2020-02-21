function Write-Log {
    [CmdletBinding()]
        Param 
        (
        [Parameter(Mandatory = $false)]
        [string]$logpath = 'C:\temp\logfile.txt',

        [Parameter(Mandatory = $true)]
        [string]$message,

        [Parameter(Mandatory = $true)]
        [ValidateSet('error', 'info', 'warning')]
        [string]$errorlevel,

        [Parameter(Mandatory = $true)]
        [ValidateSet('begin', 'process', 'end')]
        [string]$block
        )
    
    switch ($block) {
        'begin'   { $string += '[ BEGIN ] ' }
        'process' { $string += '[PROCESS] ' }
        'end'     { $string += '[  END  ] ' }
    }

    $string += Get-Date -Format g

    switch ($errorlevel) {
        'error'   { $string += ' |    Error    | ' }
        'warning' { $string += ' |   Warning   | ' }
        'info'    { $string += ' | Information | ' }
    }

    $string += $message

    $string | Out-File -FilePath $logpath -Append
    
}

Write-Log -block 'end' -errorlevel 'info' -message 'Performing some script cleanup.'

# Sample log file output;

<#
[ BEGIN ] 01/05/2019 09:31 | Information | Script has started.
[PROCESS] 01/05/2019 09:32 |   Warning   | This is a sample warning.
[PROCESS] 01/05/2019 09:32 |   Warning   | And another.
[PROCESS] 01/05/2019 09:32 |    Error    | An error has been encountered.
[  END  ] 01/05/2019 09:33 |   Warning   | Warning message.
[  END  ] 01/05/2019 09:33 | Information | Performing some script cleanup.
#>

# Simple Write-Log function.
function Write-Log($message){

    [ValidateScript({Test-Path $_})]
    $logpath = 'C:\temp\logfile.txt'

    $date = Get-Date -Format g

    Add-Content -Path $logpath -Value "$date | $message"

}

Write-Log 'Here is a sample error log.'

<#
Sample log entry;
01/05/2019 15:53 | A simple entry into the log file.
01/05/2019 15:55 | Another basic entry.
01/05/2019 15:56 | Here is a sample error log.
#>
