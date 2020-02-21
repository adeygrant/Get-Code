
function Convert-MacAddress{
    <#
        .Synopsis
        Converts mac addresses
        .Description
        Converts mac addresses
        .Example
        Convert-MacAddress -macaddress '00aabb00aabb' -add ':'
        .Example
        Convert-MacAddress -macaddress '00-aa-bb-00-aa-bb' -remove '-'
        .Example
        Convert-MacAddress -macaddress '00.aa.bb.00.aa.bb' -remove '.' -upper
        .Example
        Convert-MacAddress -macaddress '00aabb00aabb' -upper
        .Notes
        some notes.
    #>
    param (
        # Input mac address
        [Parameter(Mandatory = $true, ValueFromPipeLine = $true)]
        [string]$macaddress,
        # Character to add
        [Parameter(Mandatory = $true, ParameterSetName = 'add')]
        [Parameter(Mandatory = $false, ParameterSetName = 'remove')]
        [Parameter(Mandatory = $true, ParameterSetName = 'add_UPPER')]
        [Parameter(Mandatory = $true, ParameterSetName = 'add_LOWER')]
        [Parameter(Mandatory = $false, ParameterSetName = 'remove_UPPER')]
        [Parameter(Mandatory = $false, ParameterSetName = 'remove_LOWER')]
        [string]
        $add,
        # Character to remove
        [Parameter(Mandatory = $false, ParameterSetName = 'add')]
        [Parameter(Mandatory = $true, ParameterSetName = 'remove')]
        [Parameter(Mandatory = $false, ParameterSetName = 'add_UPPER')]
        [Parameter(Mandatory = $false, ParameterSetName = 'add_LOWER')]
        [Parameter(Mandatory = $true, ParameterSetName = 'remove_UPPER')]
        [Parameter(Mandatory = $true, ParameterSetName = 'remove_LOWER')]
        [string]
        $remove,
        # Uppercase switch parameter
        [Parameter(Mandatory = $true, ParameterSetName = 'upper')]
        [Parameter(Mandatory = $true, ParameterSetName = 'add_UPPER')]
        [Parameter(Mandatory = $true, ParameterSetName = 'remove_UPPER')]
        [switch]
        $upper,
        # Lowercase switch parameter
        [Parameter(Mandatory = $true, ParameterSetName = 'lower')]
        [Parameter(Mandatory = $true, ParameterSetName = 'add_LOWER')]
        [Parameter(Mandatory = $true, ParameterSetName = 'remove_LOWER')]
        [switch]
        $lower
    )

    function add ([string]$macaddress) {
        $macaddress = $macaddress.Insert(2, $add).Insert(5, $add).Insert(8, $add).Insert(11, $add).Insert(14, $add)
        return $macaddress
    }

    function remove ([string]$macaddress) {
        $macaddress = $macaddress -replace "$remove", ''
        return $macaddress
    }

    function upper ([string]$macaddress) {
        $macaddress = $macaddress.ToUpper()
        return $macaddress
    }

    function lower ([string]$macaddress) {
        $macaddress = $macaddress.ToLower()
        return $macaddress
    }
    
    switch ($PSCmdlet.ParameterSetName) {
        'add'          { add $macaddress               }
        'remove'       { remove $macaddress            }
        'add_UPPER'    { upper $( add $macaddress )    }
        'add_LOWER'    { lower $( add $macaddress )    }      
        'remove_UPPER' { upper $( remove $macaddress ) }
        'remove_LOWER' { lower $( remove $macaddress ) }
        'upper'        { upper $macaddress             }
        'lower'        { lower $macaddress             }
        Default        { Write-Output 'Something went wrong.' ; Exit 101 }
    }
}
