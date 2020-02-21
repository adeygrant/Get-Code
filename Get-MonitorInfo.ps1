<#
    .Synopsis
    Gets information about monitors connected to the machine.
    .Notes
    Looks to work with all output types inc VGA.
#>

$wmi = Get-WmiObject WmiMonitorID -Namespace root\wmi

Write-Output "Connected monitors: $($wmi.Count)`n"

$wmi | Foreach-Object {
    Write-Output "Manufacturer:  $(($_.ManufacturerName | ForEach-Object { [CHAR]$_ }) -join '')"
    Write-Output "Product code:  $(($_.ProductCodeID    | ForEach-Object { [CHAR]$_ }) -join '')"
    Write-Output "Serial number: $(($_.SerialNumberID   | ForEach-Object { [CHAR]$_ }) -join '')"
    Write-Output "Friendly name: $(($_.UserFriendlyName | ForEach-Object { [CHAR]$_ }) -join '')"
    Write-Output "Manufacture year: $($_.YearOfManufacture)"
    Write-Output "Manufacture week: $($_.WeekOfManufacture)`n"
}
