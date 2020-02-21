$md5  = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$utf8 = New-Object -TypeName System.Text.UTF8Encoding

$string = 'ckczppom'
$list = New-Object System.Collections.ArrayList

0..9999999 | Foreach-Object {
    $tohash = $string + '{0:d7}' -f [int]$_

    $hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($tohash)))
    $hash = $hash.Replace('-', '').ToLower()

    # i think this should be the regex? ^0{5}

if ($hash -match '^0{6}'){
        $list.Add("Hash is: $tohash and the hash was $hash") | Out-Null
    }

}

$list