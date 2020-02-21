$input = Get-Content -Path 'C:\temp\d3input.txt'

$directions = $input.ToCharArray()

$list = New-Object Collections.Generic.List[string]

$santa_x = 0
$santa_y = 0
$robo_x  = 0
$robo_y  = 0

$santasturn = $true

foreach ($move in $directions){

    if ($santasturn -eq $true){ 
        Write-Output "Santasturn = $santasturn"
        $santasturn = $false

        switch ($move) {
            '^' { $santa_y = $santa_y + 1  ; break }
            '>' { $santa_x = $santa_x + 1  ; break }
            'v' { $santa_y = $santa_y - 1  ; break }
            '<' { $santa_x = $santa_x - 1  ; break }
        }

        $list.Add("y=$santa_y, x=$santa_x")
    }
    else {
        Write-Output "Santasturn = $santasturn"
        $santasturn = $true

        switch ($move) {
            '^' { $robo_y = $robo_y + 1  ; break }
            '>' { $robo_x = $robo_x + 1  ; break }
            'v' { $robo_y = $robo_y - 1  ; break }
            '<' { $robo_x = $robo_x - 1  ; break }
        }

        $list.Add("y=$robo_y, x=$robo_x")
    }

}

$unique = $list | Select-Object -Unique
$unique.Count