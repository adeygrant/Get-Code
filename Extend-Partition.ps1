<#
.Synopsis
Extends the partition.
.Description
This script extends the C:\ drive
to it's maximum allowed value.
.Example
.\Extend-Patition.ps1
.Notes
some notes.
#>

# set a var with all the info we need
$var = Get-Partition -DriveLetter C
# get the max size we can extend to
$size = Get-PartitionSupportedSize -DiskNumber $var.DiskNumber -PartitionNumber $var.PartitionNumber | Select-Object -ExpandProperty SizeMax
# run the resize command
Resize-Partition -DiskNumber $var.DiskNumber -PartitionNumber $var.PartitionNumber -Size $size