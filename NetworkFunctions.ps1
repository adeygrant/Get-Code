function CheckIPRange {
	param(
			[ipaddress] $ipAddress,
			[ipaddress] $fromAddress,
			[ipaddress] $toAddress
		)
	
		$ip 	= $ipAddress.GetAddressBytes()
		$from 	= $fromAddress.GetAddressBytes()
		$to 	= $toAddress.GetAddressBytes()

		[array]::Reverse($ip)
		[array]::Reverse($from)
		[array]::Reverse($to)

		$ip 	= [system.BitConverter]::ToUInt32($ip, 0)
		$from 	= [system.BitConverter]::ToUInt32($from, 0)
		$to 	= [system.BitConverter]::ToUInt32($to, 0)
	
		$ip -gt $from -and $ip -le $to
}#end CheckIPRange
	
	CheckIPRange "160.5.191.79" "160.5.191.74" "160.5.191.85"


function GetIpV4Address {

	#should write one with Get-NetIPConfiguration too which is 3.0+
	#this returns an array containing v4 and v6 addresses
	$ip = (Get-WMIObject win32_NetworkAdapterConfiguration | 
	Where-Object { $_.IPEnabled 	-eq $true} | 
	Where-Object { $_.DHCPEnabled   -eq $true} | 
	Where-Object { $_.IPEnabled 	-eq $true}).IPAddress
	#from testing, it looks like the v4 address is always first so can do this.
	#plus it ensures there is just one result.
	$ip = $ip[0]
	
		return $ip

}#end GetIpV4Address

function GetIpV4Address {

	$ip = (Get-NetIPConfiguration |
	Where-Object { $_.NetAdapter.Status -ne "Disconnected"} |
	Where-Object { $_.IPv4DefaultGateway -ne $null}).IPv4Address.IPAddress

		return $ip

}

#get dns name and parse output
function Get-DNSName {
	Param
		([Parameter(Mandatory = $true)]
		[string]$ip)

		$a = nslookup $ip | Select-String "Name:"
		$a = $a.Line.Split(" .")[4].ToUpper() + "-" + $a.Line.Split(" .")[5].ToUpper()
		return $a
}#end Get-DNSName
