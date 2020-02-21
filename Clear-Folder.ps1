<#
.SYNOPSIS
Clears a folder.
.DESCRIPTION
Clears folder & sets new ACL for BUILTIN\Administrators
& SYSTEM groups with Full permissions. Takes off inheritance &
sets BUILTIN\Administrators as the owner of the folder.
.EXAMPLE
Clear-Localarchive -Path "C:\afolder"
.NOTES
Perma deletes everything in C:\afolder
.LINK
https://msdn.microsoft.com/en-us/library/system.security.accesscontrol.objectsecurity.setaccessruleprotection(v=vs.110).aspx
#>
function Clear-Localarchive {
    
        Param(
        [Parameter(Mandatory=$True)]
        [string]$path)
		
                        begin {

			#remove folder and all contents & create new      
                        cmd.exe /c rmdir /S /Q $Path
                        New-Item -Path $Path -ItemType "directory" | Out-Null
                        }#begin

                        process {
                        
                        #create ACL object
                        $newACL = New-Object System.Security.AccessControl.DirectorySecurity

                        #Define owner
                        $owner = New-Object System.Security.Principal.NTAccount('BUILTIN\Administrators')
                        
                        #define users permissions
                        $systemRule = New-Object System.Security.AccessControl.FileSystemAccessRule (
                        "NT Authority\SYSTEM","Full","ContainerInherit,ObjectInherit","None","Allow")
                        $adminRule = New-Object System.Security.AccessControl.FileSystemAccessRule (
                        "BUILTIN\Administrators","Full","ContainerInherit,ObjectInherit","None","Allow")

                        #add the rules to the acl
                        $newACL.SetAccessRule($systemRule)
                        $newACL.SetAccessRule($adminRule)
                        $newAcl.SetOwner($owner)
                        
                        #Disbale inheritance
                        $newAcl.SetAccessRuleProtection($True,$false)

                        #set the acl to the folder
                        Set-ACL -Path $Path $newACL
                        }#process

                        end {

                        Write-Host "Permissions for $path set to:"
                        Get-ACL -Path $Path | Select-Object -ExpandProperty Access | Format-List
                        }
						
                }
                
Clear-Localarchive -path "C:\localarchive"