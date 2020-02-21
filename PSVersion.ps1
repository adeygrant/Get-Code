<#
.SYNOPSIS
Gets version number & catches in a switch.
.DESCRIPTION
Gets version number & catches in a switch.
.EXAMPLE
.\PSVersion.ps1
.NOTES
sample notes...
#>
function Get-PSVersion {

	     $versionshort = $PSVersionTable.PSVersion.Major
            $versionlong  = $PSVersionTable.PSVersion.ToString()
        
		switch ($versionshort) {
			2 	{ Write-Host 	 "Version: $versionlong" }
			3 	{ Write-Host 	 "Version: $versionlong" }
			4 	{ Write-Host 	 "Version: $versionlong" }
            5 	{ Write-Host 	 "Version: $versionlong" }
        Default { Write-Host     "Must be version 1."    }
        }

}

Get-PSVersion