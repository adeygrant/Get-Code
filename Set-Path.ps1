function Set-Path {
    <#
        .Synopsis
        This script configures the environment path variable.
        .Description
        Allows you to configure entiries in the path variable - Insert and remove
        at specified indexes.
        .Example
        Set-Path
        Set-Path -path 'C:\test\path\' -insert 2
        Set-Path -remove 2
        .Notes
        sample notes
    #>
    [CmdletBinding(DefaultParameterSetName = 'show')]
    Param(
        # Path
        [Parameter(Mandatory = $false)]
        [string]$path,
        # Insert path at index
        [Parameter(Mandatory = $false, ParameterSetName = 'insert')]
        [int]$insert,
        # Remove item at index
        [Parameter(Mandatory = $false, ParameterSetName = 'remove')]
        [int]$remove
    )
    
    $regkeypath = 'HKLM:\SYSTEM\ControlSet001\Control\Session Manager\Environment\'
    $list = New-Object System.Collections.ArrayList
    $array = (Get-ItemPropertyValue -Path $regkeypath -Name 'Path').Trim(';').Split(';')

    # Create the list.
    foreach($item in $array){
        $list.Add($item) | Out-Null
    }

    # Print the list.
    function printlist{
        for ($i = 0; $i -lt $list.Count; $i++) {
            $i.ToString()+ " | " + $list[$i] | Write-Output
        }
    }

    # Apply changes.
    function applychanges{
        foreach ($item in $list){
            $regkey = $regkey + $item + ";"
        }

        Set-ItemProperty -Path $regkeypath -Name 'Path' -Value $regkey
    }

    switch ($PSCmdlet.ParameterSetName) {
        'insert' {  Write-Output "Inserting $path at position $insert...`n"
                    $list.Insert($insert, $path)
                    printlist
                    applychanges
                    break
                 }
        'remove' {  Write-Output "Removing position $remove...`n"
                    $list.RemoveAt($remove)
                    printlist
                    applychanges
                    break
                 }
        'show'   { printlist ; break }
    }

}

Set-Path -insert 0 -path "C:\testpath\"
