$input = Get-Content -Path 'C:\temp\d2input.txt'

foreach($box in $input){
    
    $stringarray = $box.Split('x')
    
    [int]$height = $stringarray[0]
    [int]$width  = $stringarray[1]
    [int]$length = $stringarray[2]

    $array = @($height, $width, $length) | Sort-Object

    $volume = (($array[0] * $array[1]) + ($array[0] * $array[2]) + ($array[1] * $array[2])) * 2

    $extra = $array[0] * $array[1]

    $parcel = $volume + $extra

    $total = $total + $parcel

}

$total