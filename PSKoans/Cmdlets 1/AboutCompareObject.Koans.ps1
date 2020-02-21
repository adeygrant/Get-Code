﻿using module PSKoans
[Koan(Position = 205)]
param()
<#
    Compare-Object

    Compare-Object is primarily for comparing collections of objects rather than individual
    items, and is usually used to display data comparisons to the user.
#>
Describe 'Compare-Object' {

    It 'compares collections of objects' {
        $Comparison = @{
            ReferenceObject  = 'this', 'is', 'the', 'reference'
            DifferenceObject = 'these', 'is', 'the', 'difference'
        }
        $CompareData = Compare-Object @Comparison
        $CompareData[0].InputObject | Should -Be 'these'
        $CompareData[0].SideIndicator | Should -Be '=>'
        $CompareData[0] | Should -BeOfType 'System.Management.Automation.PSCustomObject'
    }

    It 'can display items that occur in both sets' {
        # By default, items that are the same in both collections are hidden.
        $Comparison = @{
            ReferenceObject  = 'this', 'is', 'the', 'reference'
            DifferenceObject = 'these', 'is', 'the', 'difference'
        }
        $CompareData = Compare-Object @Comparison -IncludeEqual
        $CompareData.SideIndicator -contains '==' | Should -BeTrue
        $CompareData.Where{$_.InputObject -eq 'the'}.SideIndicator | Should -Be '=='
    }
}