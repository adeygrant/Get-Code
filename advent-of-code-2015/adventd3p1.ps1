$input = Get-Content -Path 'C:\temp\d3input.txt'

$directions = $input.ToCharArray()

$list = New-Object Collections.Generic.List[string]

$y = 0
$x = 0

$coordinates = "y=$y, x=$x"

$list.Add($coordinates)

foreach ($move in $directions){

    switch ($move) {
        '^' { $y = $y + 1  ; break }
        '>' { $x = $x + 1  ; break }
        'v' { $y = $y - 1 ; break }
        '<' { $x = $x - 1 ; break }
    Default { "Something went wrong."       }
    }
    
    $list.Add("y=$y, x=$x")

}

$uniquelist = $list | Select-Object -Unique

$uniquelist.Count