$input = Get-Content -Path "$PSScriptroot\d1_input.txt"

$list = New-Object Collections.Generic.List[int]

function calculate_fuel($fuel){

    # Divide by three minus two
    $fuel = [double]$fuel / 3 - 2

    # Round down
    $fuel = [Math]::floor($fuel)

    return $fuel

}

foreach ($module_mass in $input){

    # 9 / 3 - 2 = 1
    # 8 / 3 - 2 = 0

    $fuel = calculate_fuel($module_mass)
    Write-Output "original adding $fuel"
    $list.Add($fuel)

    while ($fuel -gt 8) {
        $fuel = calculate_fuel($fuel)
        Write-Output "adding $fuel"
        $list.Add($fuel)
    }

}

$list | Measure-Object -Sum | Select-Object -ExpandProperty 'Sum'