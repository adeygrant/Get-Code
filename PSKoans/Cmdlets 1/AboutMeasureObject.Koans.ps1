using module PSKoans
[Koan(Position = 206)]
param()
<#
    Measure-Object

    Measure-Object is, as its name implies, a utility cmdlet that
    performs mathematical operations on collections of objects.
#>
Describe 'Measure-Object' {
    BeforeAll {
        $Numbers = @(
            839, 339, 763, 663, 238, 427, 577, 613, 284, 453
            850, 130, 250, 843, 669, 972, 572, 41, 172, 155
            729, 616, 285, 231, 128, 540, 204, 584, 407, 98
            668, 85, 320, 435, 87, 719, 936, 25, 75, 122
            665, 154, 943, 35, 391, 816, 420, 229, 3, 938
        )

        $Files = Get-ChildItem -Path $home -Recurse -Depth 2
    }

    It 'can count objects' {
        $Numbers |
            Measure-Object -Sum |
            Select-Object -ExpandProperty Count |
            Should -Be 50

        $Files |
            Measure-Object -Sum |
            Select-Object -ExpandProperty Count |
            Should -Be 65
    }

    It 'can sum numerical objects' {
        $StopIndex = 10

        $Numbers[0..$StopIndex] |
            Measure-Object -Sum |
            Select-Object -ExpandProperty Sum |
            Should -Be 6046
    }

    It 'can average numerical objects' {
        $StartIndex = 20

        $Numbers[$StartIndex..25] |
            Measure-Object -Average |
            Select-Object -ExpandProperty Average |
            Should -Be 421.5
    }

    It 'can find the largest or smallest value' {
        $StopIndex = 16

        $Values = $Numbers[5..$StopIndex] |
            Measure-Object -Minimum -Maximum

        $Values.Minimum | Should -Be 130
        $Values.Maximum | Should -Be 972
    }

    It 'can find multiple values at once' {
        $StartIndex = 25
        $StopIndex = 35

        $Values = $Numbers[$StartIndex..$StopIndex] |
            Measure-Object -Average -Minimum -Sum

        # 'Count' is always present in the data from Measure-Object
        $Values.Count | Should -Be 11
        $Values.Minimum | Should -Be 85
        $Values.Average | Should -Be 377
        $Values.Sum | Should -Be 4147
    }

    It 'can operate on object properties' {
        $Data = $Files.BaseName | Measure-Object -Property Length -Sum -Average
        $Data.Sum | Should -Be 1136
        $Data.Average | Should -Be '17.4769230769231'
    }

    It 'can measure text lines, characters, and words of strings' {
        $Text = Get-Content "$env:PSKoans_Folder/Foundations/AboutTheStockChallenge.Koans.ps1"
        $Data = $Text | Measure-Object -Line -Word -Character

        $Data.Lines | Should -Be 73
        $Data.Words | Should -Be 219
        $Data.Characters | Should -Be 3135
    }
}