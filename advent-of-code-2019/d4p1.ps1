$range = 356261..846303
$list = New-Object System.Collections.Generic.List[bool]

function checkForDouble($password){
    # Check for double adjacent digit
    return $password -match '(\d){1}\1'
}

function checkForSequence($password){
    # Check for incremental sequence

    $unsortchararray = [int[]](($password -split '') -ne '')
    $sortedchararray = [int[]](($password -split '') -ne '') | Sort-Object

    # Need them back as string because if you compare arrays it gets tricky with the array order
    $unsortstring = -join $unsortchararray
    $sortedstring = -join $sortedchararray

    return $unsortstring -eq $sortedstring
}

$range | ForEach-Object {

    $double   = checkForDouble($_)
    $sequence = checkForSequence($_)

    if($double -eq $true -and $sequence -eq $true){
        $list.Add($_)
    }

}

Write-Output "Answer is $($list.Count)"