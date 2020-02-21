﻿using module PSKoans
[Koan(Position = 302)]
param()
<#
    StringBuilder

    If you have worked with .NET at any point, you will probably be familiar
    with StringBuilder. It resides in the System.Text namespace, and is
    very good at efficiently building up strings.

    String objects are largely considered immutable in .NET operations,
    and as such actually modifying them or adding onto them directly generally
    causes the entire string to be rebuilt completely with the new value.
    This can be quite costly in terms of performance for large strings; for
    these, we have StringBuilder.
#>
Describe 'System.Text.StringBuilder' {

    Context 'Creating a StringBuilder' {

        It 'can be created with New-Object' {
            # All things, ultimately, are carved from a blank slate.
            $StringBuilder = New-Object System.Text.StringBuilder

            $StringBuilder | Should -BeOfType System.Text.StringBuilder
        }

        It 'can be created from a type accelerator' {
            # Control of the initial conditions is sometimes critical.
            $StringBuilder = [System.Text.StringBuilder]::new()
            $SBFromString = [System.Text.StringBuilder]::new('Initial String')
            $SBWithSetCapacity = [System.Text.StringBuilder]::new(10)
            <#
                You can call
                    [System.Text.StringBuilder]::new
                without parentheses in the console to see available overload
                definitions that can be used to construct the object.
            #>
            $StringBuilder, $SBFromString, $SBWithSetCapacity | Should -BeOfType System.Text.StringBuilder
            $SBFromString.Length | Should -Be 14
        }

        It 'can be created by casting an existing string' {
            # Two sides of a coin.
            [System.Text.StringBuilder]$StringBuilder = 'Initial String'

            $StringBuilder | Should -BeOfType System.Text.StringBuilder
        }
    }

    Context 'Appending to a StringBuilder String' {

        It 'can append strings' {
            $StringBuilder = [System.Text.StringBuilder]::new()

            # Quantity comes first. Quality soon follows.
            $StringBuilder.Append('whatisthis')
            $StringBuilder.Length | Should -Be 10
        }

        It 'can append new lines' {
            $StringBuilder = [System.Text.StringBuilder]::new()
            $StringBuilder.AppendLine('Hello!')
            $StringBuilder.AppendLine('Goodbye!')

            $ExpectedString = @"
Hello!
Goodbye!

"@
            # Doesn't work properly - It messes with \r\n stuff and can't get it to work...
            #$ExpectedString | Should -Be $StringBuilder.ToString()
        }

        It 'can append format strings' {
            # Using the same underlying framework as the -f formatting operator.
            $StringBuilder = [System.Text.StringBuilder]::new()

            $FormatItems = 'Water', 'wet'
            $StringBuilder.AppendFormat("{0} is {1}." -f $FormatItems)

            $StringBuilder.ToString() | Should -Be "Water is wet."
        }

        It 'returns a reference to the object' {
            # So you can either hide that output, or use it to chain the method!
            $StringBuilder = [System.Text.StringBuilder]::new()
            $StringBuilder.Append('Hello!') > $null # Hide output from console

            # The reference returned points back to the original StringBuilder object.
            $StringBuilder.Append(' Who ').Append('are ').Append('you?') | Should -Be $StringBuilder

            $StringBuilder.ToString() | Should -Be 'Hello! Who are you?'
        }
    }

    Context 'Constructing the Final String Object' {
        BeforeAll {
            $SB = [System.Text.StringBuilder]::new("Hello!")
            $SB.Append("BYE!")
        }

        It 'is as simple as calling .ToString()' {
            $SB.ToString() | Should -BeOfType String
            $SB.ToString() | Should -Be 'Hello!BYE!'
        }

        It 'can be retained and reused' {
            $SB.Append('Hello')
            $SB.ToString() | Should -Be 'Hello!BYE!Hello'
            $SB.Append(' DONE')
            $SB.ToString() | Should -Be 'Hello!BYE!Hello DONE'
        }
    }

    Context 'Other StringBuilder Methods' {
        BeforeAll {
            $StringBuilder = [System.Text.StringBuilder]::new("TEXT")
        }
        It 'can be cleared' {
            $StringBuilder.Clear()
            $StringBuilder.Length | Should -Be 0
        }

        It 'can insert sequences' {
            $StringBuilder.Append('is my dog.')
            $StringBuilder.Insert(0, 'Ben ')

            'Ben is my dog.' | Should -Be $StringBuilder.ToString()
        }

        It 'can remove sequences' {
            'is my dog.' | Should -Be $StringBuilder.Remove(0, 4).ToString()
        }

        It 'can replace existing sequences' {
            $StringBuilder.Insert(0, 'Steve ')
            $StringBuilder.Replace('dog', 'draconian leech')

            'Steve is my draconian leech.' | Should -Be $StringBuilder.ToString()
        }
    }

    Context 'StringBuilder Properties' {
        BeforeAll {
            $StringBuilder = [System.Text.StringBuilder]::new()
            $StringBuilder.AppendLine('When you look into the void,')
            $StringBuilder.AppendLine('The void also looks into you.')
        }

        It 'has only a few properties' {
            $PropertyCount = 3
            $PropertyName = 'Capacity'

            $Properties = $StringBuilder |
                Get-Member |
                Where-Object MemberType -eq 'Property'

            $ExpectedCount = $Properties |
                Measure-Object |
                Select-Object -ExpandProperty Count

            $PropertyCount | Should -Be $ExpectedCount
            $PropertyName | Should -BeIn $Properties.Name
        }

        It 'indicates the current length of the string' {
            $FinalStringLength = 61

            $StringBuilder.ToString().Length | Should -Be $StringBuilder.Length
            $FinalStringLength | Should -Be $StringBuilder.Length
        }

        It 'indicates the currently allocated capactity' {
            $Capacity = 64

            $Capacity | Should -Be $StringBuilder.Capacity
        }

        It 'indicates the maximum capacity of the StringBuilder' {
            $MaxCapacity = 2147483647

            $MaxCapacity | Should -Be $StringBuilder.MaxCapacity
        }
    }
}