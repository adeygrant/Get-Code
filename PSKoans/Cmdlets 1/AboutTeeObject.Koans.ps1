using module PSKoans
[Koan(Position = 209)]
param()
<#
    Tee-Object

    Tee-Object is a utility cmdlet that splits the path of pipeline
    objects. It directly passes through all objects that it receives,
    as well as storing a copy of the items either in a file or variable.
#>
Describe 'Tee-Object' {

    It 'passes the object on through the pipeline' {
        1..10 | Tee-Object -Variable n | Should -Be @(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    }

    It 'can store the object(s) into a variable' {
        $numbers = @('alpha', 'beta', 'gamma')
        # Note the variable name is passed as a string, without the $!
        'alpha', 'beta', 'gamma' | Tee-Object -Variable 'Numbers' | Should -Be $Numbers
        $Numbers[1] | Should -Be 'beta'
    }

    It 'can also store the object(s) into a file' {
        $File = New-TemporaryFile

        1..5 | ForEach-Object {"{0:N2}" -f (1 / $_)} | Tee-Object -FilePath $File.FullName | Should -Be @(1.0, 0.5, 0.33, 0.25, 0.20)
        $File | Get-Content | Should -Be @(1.0, 0.5, 0.33, 0.25, 0.20)
    }
}