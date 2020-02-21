$input = Get-Content -Path "$PSScriptRoot\d2_input.txt"
$array = $input.Split(',') | ForEach-Object { Invoke-Expression $_ }

$length = $array.Length

for ($i = 0; $i -le $length; $i++){

    [int]$inputAposition = $array[$i + 1]
    [int]$inputBposition = $array[$i + 2]
    [int]$output         = $array[$i + 3]

    [int]$inputA = $array[$inputAposition]
    [int]$inputB = $array[$inputBposition]

    switch ($array[$i]) {
        1  { $array.Item($output) = $inputA + $inputB }
        2  { $array.Item($output) = $inputA * $inputB }
        99 { break }
    }
    
    $i += 3

}

Write-Output "Answer: $($array[0])"