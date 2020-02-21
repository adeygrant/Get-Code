<#
.SYNOPSIS
Scripted printer installation.
.DESCRIPTION
Installs printers.
Needs the driver already on C:\ for it to work.
The script did have a wget in but I took it out 
to make it simpler. I've tried the begin proc and 
end blocks so it will accept multiple printers
from pipeline. Not tested though...?
.EXAMPLE
Install-Printer "printer1.hostname.co.uk"
#>
function Insatll-Printer
{
    [CmdletBinding()]
        Param(
                [Parameter(
                        Mandatory=$True,
                        ValueFromPipeline=$True)]
                        [string]$hostname)

        begin {
        #Extract driver
        C:\temp\o149u1en_w_plc6pd202_32_64.exe -oC:\temp\canongeneric -y | Out-Null

        #Install driver
        if ($ENV:PROCESSOR_ARCHITECTURE = "AMD64"){
                pnputil.exe -i -a "C:\temp\canongeneric\uk_eng\x64\Driver\pcl6\CNP60KA64.INF"
                Add-PrinterDriver -Name "Canon Generic PCL6 Driver" }
        else{   pnputil.exe -i -a "C:\temp\canongeneric\uk_eng\32BIT\Driver\pcl6\CNP60K.INF"
                Add-PrinterDriver -Name "Canon Generic PCL6 Driver" }
        }#end begin block

        process{
        #Install Printer Port
        Add-PrinterPort -Name  "IP_$hostname" -PrinterHostAddress $hostname
        #Install Printer
        Add-Printer -Name $hostname -DriverName "Canon Generic PCL6 Driver" -PortName "IP_$hostname"
        }#end process block

        end{
        #Cleanup
        Remove-Item C:\temp\canongeneric\ -Recurse -Force
        Remove-Item C:\temp\o149u1en_w_plc6pd202_32_64.exe
        }#end end block
}#end Install-Printer

Install-Printer "printer1.hostname.co.uk"
