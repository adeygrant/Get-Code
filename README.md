## Get-Code
Powershell repo for code snippets, scripts, functions etc. Some files contain multiple functions / snippets in an attempt to organise things abit better. See the grid below - it highlights some of the important stuff inside the scripts so I can reference them more easily in future projects.

Best practices book [here.](https://github.com/PoshCode/PowerShellPracticeAndStyle)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Script&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  | Function
------------- | -------------
[Addtext.ps1](https://github.com/adeygrant/Get-Code/blob/master/Addtext.ps1) | A quick demo of here-string block / Adding a block of text to a var.
[Clear-Folder.ps1](https://github.com/adeygrant/Get-Code/blob/master/Clear-Folder.ps1) | ACLs basically. The PS alternative to icacls
[Create-Shortcut.ps1](https://github.com/adeygrant/Get-Code/blob/master/Create-Shortcut.ps1) | Says on the tin. Basic Validate script.
[Disable-FPSharing.ps1](https://github.com/adeygrant/Get-Code/blob/master/Disable-FileandPrintSharing.ps1) | Disable-NetAdapterBinding. Set-NetFirewallRule.
[Extend-Partition.ps1](https://github.com/adeygrant/Get-Code/blob/master/Extend-Partition.ps1) | Get-Partition. Get-PartitionSupportedSize. Resize-Partition.
[Get-CompInfo.ps1](https://github.com/adeygrant/Get-Code/blob/master/Get-CompInfo.ps1)  | Essentially a demo function of the Win32_ComputerSystem class & $PSBoundParameters.
[Get-File.ps1](https://github.com/adeygrant/Get-Code/blob/master/Get-File.ps1)  | Example of multiple parameter sets.
[Get-OSInfo.ps1](https://github.com/adeygrant/Get-Code/blob/master/Get-OSInfo.ps1) | Basic demo function of the Win32_OperatingSystem class.
[Get-StringHash.ps1](https://github.com/adeygrant/Get-Code/blob/master/Get-StringHash.ps1)  | MD5 hash stuff. Pipeline input.
[Install-Printer.ps1](https://github.com/adeygrant/Get-Code/blob/master/Install-Printer.ps1) | Printer installation script. Pretty standard stuff.
[NetworkFunctions.ps1](https://github.com/adeygrant/Get-Code/blob/master/NetworkFunctions.ps1) | IP range checker. IP address retrival for 2.0+ and 3.0+.
[PSVersion.ps1](https://github.com/adeygrant/Get-Code/blob/master/PSVersion.ps1) | $PSVersionTable and a switch.
[Password-Functions.ps1](https://github.com/adeygrant/Get-Code/blob/master/Password-Functions.ps1) | ValidateRange, ASCII stuff. [CHAR]. Two functions that generate passwords.
[RenameComputer.ps1](https://github.com/adeygrant/Get-Code/blob/master/RenameComputer.ps1) | ReturnValue switch. Win32_ComputerSystem.Rename
[Set-NicPower.ps1](https://github.com/adeygrant/Get-Code/blob/master/Set-NicPower.ps1) | Get-NetAdapter.
[Set-Path.ps1](https://github.com/adeygrant/Get-Code/blob/master/Set-Path.ps1) | Default parameter set. Registry key get & set. For loop.
[Set-Perms.ps1](https://github.com/adeygrant/Get-Code/blob/master/Set-Perms.ps1) | Validate script. Validate pattern, regex, $PSBoundParameters, icacls...
[Show-Verbose.ps1](https://github.com/adeygrant/Get-Code/blob/master/Show-Verbose.ps1) | Basic demo script showing good usage of -verbose + begin, process and end blocks.
[Start-Bitlocker.ps1](https://github.com/adeygrant/Get-Code/blob/master/Start-Bitlocker.ps1) | Good function layout for advanced function. Use of Splatting.
[Update-Bios.ps1](https://github.com/adeygrant/Get-Code/blob/master/Update-Bios.ps1) | Start-Process and return / exit code stuff. Two commands on single line with ;
[Validate.ps1](https://github.com/adeygrant/Get-Code/blob/master/Validate.ps1) | Some examples of validation scripts outside of param declaratoins.
[Write-Log.ps1](https://github.com/adeygrant/Get-Code/blob/master/Write-Log.ps1) | Simple & advanced function. Add-Content. Validate set.
[example.ps1](https://github.com/adeygrant/Get-Code/blob/master/example.ps1) | Layout / template for a function including Get-Help comment stuff.
