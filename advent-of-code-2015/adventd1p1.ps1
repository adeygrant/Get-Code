$input = Get-Content -Path 'C:\temp\input.txt'

$array = $input.ToCharArray()

$opencount
$closecount

foreach ($char in $array){
    
    
    if ($char -eq '('){
        $opencount++
    }
    if ($char -eq ')'){
        $closecount++
    }

}

$floor = $opencount - $closecount
$floor