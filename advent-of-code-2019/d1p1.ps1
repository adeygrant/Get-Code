$input = Get-Content -Path "$PSScriptroot\d1_input.txt"

$list = New-Object Collections.Generic.List[int]

foreach ($fuel_req in $input){
    
    # Divide by three
    $fuel = [double]$fuel_req / 3 - 2

    # Round down
    $fuel = [Math]::floor($fuel)

    $list.Add($fuel)

}

$list | Measure-Object -Sum