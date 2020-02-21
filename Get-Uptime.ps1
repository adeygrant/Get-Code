function Get-Uptime {
    <#
        .Description
	    Gets PC uptime.
        .Example
        Get-Uptime
    #>

$lastboot = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty LastBootUpTime

Write-Host "Last boot time:" $lastboot.DayOfWeek $lastboot

(Get-Date) - $lastboot | Select-Object -Property Days, Hours, Minutes, Seconds

}

<#
#sample output:

Last boot time: Friday 24/05/2019 08:31:35

Days Hours Minutes Seconds
---- ----- ------- -------
   0     1      37      55
#>
