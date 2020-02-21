$content = Get-Content -Path 'C:\temp\d5input.txt'
<#

A nice string is one with all of the following properties:

It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
It contains at least one letter that appears twice in a row, 
    like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
It does not contain the strings ab, cd, pq, or xy, even if 
    they are part of one of the other requirements.

    'How many strings are nice?'

#>

$list = New-Object System.Collections.ArrayList

$content | ForEach-Object{
    
    switch -Regex ( $_ ){
        # match the strings 'ab', 'cd', 'pq, 'xy'. This is first because we drop this if found.
                        'ab|cd|pq|xy' { Write-Output "$_ contains one of the excluded items."
                                        break
                                      }
        # match 3 vowels.
        '[aeiou].*[aeiou].*[aeiou]'  { Write-Output "$_ contains at least three vowels."
                            # match a double a-z character
                            if ($_ -match "([a-z])\1" ){
                                Write-Output "$_ contains a double a-z character also"
                                $list.Add($_) | Out-Null
                            }
                      }
    default           { Write-Output "$_ did not match anything" }
    }
}

$list.Count