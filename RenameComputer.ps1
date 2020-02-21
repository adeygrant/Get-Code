function RenameComputer {
	Param
		([Parameter(Mandatory = $true)]
		[string]$NewCompterName)

	Write-Host "Changing name to" $NewCompterName
		
	try{	
		$var = (Get-WmiObject Win32_ComputerSystem).Rename($NewCompterName)
			switch ($var.ReturnValue) {
				0 	{ Write-Host 	 "Success. Return value = $_." 
					Exit $_ }
				5 	{ Write-Host 	 "Failure. Return value = $_. Access denied. Possibly need admin rights."
					Exit $_ }
				Default { Write-Host 	 "Failure. Return value = $_."
					Exit $_ }
			}#end switch
		}#end try
	catch{
		Write-Host "Error occurred."
			Exit 101
		}#end catch
}#end RenameComputer
