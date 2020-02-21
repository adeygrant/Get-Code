$input = Get-Content -Path 'C:\temp\input.txt'

$array = $input.ToCharArray()

$opencount
$closecount
$index

foreach ($char in $array){

    $index++
    
    if ($char -eq '('){
        $opencount++
    }
    if ($char -eq ')'){
        $closecount++
    }

    $floor = $opencount - $closecount

    if ($floor -eq -1){
        $index
        break
    }

}