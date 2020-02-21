$content = Get-Content -Path 'C:\temp\d5input.txt'

<#
  Now, a nice string is one with all of the following properties:

  It contains a pair of any two letters that appears at least 
  twice in the string without overlapping, like xyxy (xy) or 
  aabcdefgaa (aa), but not like aaa (aa, but it overlaps).

  It contains at least one letter which repeats with exactly one
  letter between them, like xyx, abcdefeghi (efe), or even aaa.
#>

$list = New-Object System.Collections.ArrayList

$content | ForEach-Object{
    
    switch -Regex ( $_ ){
        # Any a-z char. Followed by any other a-z char. Then one of the first capture group. eg. aga or efe
        '([a-z])[a-z]{1}\1'   { 
                        Write-Output "match"
                      }
        # Match any pair of letters in the string. eg. qjhvhtzxzqqjkmpb should match bc 'qj' appears twice
        'regexhere'   { 
                        Write-Output "match"
                      }
    default           { Write-Output "$_ did not match anything" }
    }
}