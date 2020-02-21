using module PSKoans
[Koan(Position = 107)]
param()
<#
    Comparison Operators

    Comparison operators are often used to compare two values. If the values
    satisfy the condition set by the operator, the expression returns $true;
    otherwise, it returns $false.

    Mathematical comparison operators are two letters preceded by a hyphen:
    -eq, -ne, -gt, -lt, -le, -ge

    Logical comparison operators include:
    -and, -or, -xor, -not

    For more information, see: 'Get-Help about_Operators'
#>
Describe 'Comparison Operators' {

    Context '-eq and -ne' {

        It 'is a simple test' {
            $true -eq $false | Should -Be $false
            1 -eq 1 | Should -Be $true
        }

        It 'will attempt to convert types' {
            # Boolean values are considered the same as 0 or 1 in integer terms, and vice versa
            $true -eq 1 | Should -Be $true
            $false -ne 0 | Should -Be $false
            $true -eq 10 | Should -Be $true # What about higher numbers?
            -10 -eq $false | Should -Be $false # What about negative numbers?

            10 -ne 1 | Should -Be $true

            # Strings and numbers will also be converted if possible
            '1' -eq 1 | Should -Be $true
            10 -ne '10' | Should -Be $false
        }

        It 'has a strict behaviour with most strings' {
            # Strings containing text behave a little differently in some cases
            'string' -eq 1 | Should -Be $false

            # How should strings cast to boolean?
            $true -eq 'Hello!' | Should -Be $true

            # What about an empty string?
            $true -eq '' | Should -Be $false

            # What about a string containing a number?
            $false -ne '0' | Should -Be $true

            # In short: strings don't care about their contents when cast to boolean
            $true -eq 'False' | Should -Be $true
            $false -eq [string]$false | Should -Be $false
            [string]$false | Should -Be 'false'
        }

        It 'changes behaviour with arrays' {
            # Note that the array must always be on the left hand side of the comparison
            $Array = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

            $Array -eq 2 | Should -Be 2
            $Array -eq 11 | Should -Be $null
            $Array -ne 5 | Should -Be @(1, 2, 3, 4, 6, 7, 8, 9, 10)
        }
    }

    Context '-gt and -lt' {

        It 'will compare values' {
            11 -gt 6  | Should -BeTrue
            15 -gt 14 | Should -BeTrue

            10 -lt 20 | Should -BeTrue
            -10 -lt 0  | Should -BeTrue
        }

        It 'will often return many items from arrays' {
            $Array = 1, 5, 10, 15, 20, 25, 30

            $Array -gt 30 | Should -Be $null
            $Array -lt 10 | Should -Be @(1, 5)

        }
    }

    Context '-ge and -le' {

        It 'is a combination of the above two types' {
            $Array = 1, 2, 3, 4, 5

            $Array -ge 3 | Should -Be @(3, 4, 5)
            $Array -le 2 | Should -Be @(1, 2)
            $Array -ge 5 | Should -Be @(5)
        }
    }

    Context '-contains and -notcontains' {

        It 'returns $true if the right hand value occurs in the left hand array' {
            $Array = 1, 2, 3, 4, 5
            $SearchValue = 5

            $Array -contains $SearchValue | Should -BeTrue
        }

        It 'will always return $false with an array on the right hand side' {
            $Value = '1'
            $Array = 1, 2, 3, 4, 5

            $Value -contains $Array | Should -Be $false

            $Array -contains @(1, 2) | Should -Be $false
        }

        It 'has a logical opposite' {
            $Array = 1, 2, 3, 4, 5
            $Value = 3

            $Array -notcontains $Value | Should -Be $false
        }
    }

    Context '-in and -notin' {

        It 'is the inverse of -contains' {
            $Array = 1, 2, 3, 4, 5
            $SearchValue = 1

            $SearchValue -in $Array | Should -BeTrue
        }

        It 'also has a logical opposite' {
            $Array = 4, 3, 1, 5, 2
            $SearchValue = 4

            $SearchValue -notin $Array | Should -BeFalse
        }
    }
}

Describe 'Logical Operators' {
    <#
        Logical operators have lower precedence in PowerShell than comparison operators, and compare
        against boolean values.
    #>
    Context '-and' {

        It 'returns $true only if both inputs are $true' {
            $true -and $true | Should -BeTrue
            $false -and $true | Should -Be $false
        }

        It 'may coerce values to boolean' {
            $String = ''
            $Number = 1

            $String -and $Number | Should -Be $false
        }
    }

    Context '-or' {

        It 'returns $true if either input is $true' {
            $true -or $false | Should -Be $true
            $false -or $true | Should -Be $true
            $true -or $true | Should -Be $true
        }

        It 'may coerce values to boolean' {
            $String = 'test'
            $Number = 0

            $String -or $Number | Should -Be $true
        }
    }

    Context '-xor' {

        It 'returns $true if only one input is $true' {
            $true -xor $false | Should -Be $true
            $true -xor $true | Should -Be $false
            $false -xor $false | Should -Be $false
        }
    }

    Context '-not' {

        It 'negates a boolean value' {
            -not $true | Should -Be $false
            -not $false | Should -Be $true
        }

        It 'can be shortened to !' {
            !$true | Should -Be $false
        }
    }
}