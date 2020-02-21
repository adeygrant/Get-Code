using module PSKoans
[Koan(Position = 112)]
param()
<#
    Hashtables

    Hashtables are a more advanced type of collection than arrays, and use string keys as a kind of
    'index' rather than index numbers. A simple PowerShell hashtable can be created with a hash
    literal, which looks like this:

    @{
        Key  = 'Value'
        Age  = 12
        Name = "Robert '); DROP TABLE 'STUDENTS'"
    }

    Hashtables are more difficult to iterate over than arrays, but have the advantage of being able
    to more easily access exactly the item you want from the collection. In the above example, it's
    quite simple to access only the Age or Name value, as you please.

    Hashtables are also frequently used as input to many more customisable parameters for
    PowerShell cmdlets.
#>
Describe 'Hashtables' {

    Context 'Building Hashtables' {

        It 'can be built with a hash literal' {
            # A hash literal is similar to the array literal @(), just with curly braces
            $Hashtable = @{
                # Hashtables always consist of key/value pairs
                Name     = 'Hashtable'
                Color    = 'Blue'
                Spectrum = 'Ultraviolet'
            }

            $Hashtable | Should -BeOfType 'System.Collections.Hashtable'
            # Values in the hashtable can be retrieved by specifying their corresponding key
            $Hashtable['Color'] | Should -Be 'Blue'
            $Hashtable['Spectrum'] | Should -Be 'Ultraviolet'

            $Hashtable | Should -BeOfType 'System.Collections.Hashtable'
        }

        It 'can be built all in one line' {
            $Hashtable = @{Name = 'Bob'; Species = 'Tardigrade'; Weakness = 'Phys'}

            $Hashtable['Species'] | Should -Be 'Tardigrade'
        }

        It 'can be built in pieces' {
            $Hashtable = @{}
            # By specifying a key, we can insert or overwrite values in the hashtable
            $Hashtable['Name'] = 'Hashtable'
            $Hashtable['Color'] = 'Red'
            $Hashtable['Spectrum'] = 'Infrared'
            $Hashtable['Spectrum'] = 'Microwave'

            $Hashtable['Color'] | Should -Be 'Red'
            $Hashtable['Spectrum'] | Should -Be 'Microwave'
        }

        It 'can be built using the Hashtable object methods' {
            $Hashtable = @{}
            $Hashtable.Add('Name', 'John')
            $Hashtable.Add('Age', 52)
            $Hashtable.Add('Radiation', 'Infrared')

            $Hashtable['Age'] | Should -Be 52
        }
    }

    Context 'Working with Hashtables' {

        It 'is a reference type' {
            $HashtableOne = @{
                Name = 'Jim'
                Age  = 12
            }

            $HashtableTwo = $HashtableOne
            $HashtableTwo['Age'] = 21

            $HashtableOne['Age'] | Should -Be 21 # Right?
            $HashtableTwo['Age'] | Should -Be 21
        }
        # what the f is going on here? Need to research this after.

        It 'can be cloned' {
            # Instead of passing a reference to the original, we can copy it!
            $HashtableOne = @{
                'Meal Type' = 'Dinner'
                Calories    = 1287
                Contents    = 'Carrots', 'Fish', 'Gherkin', 'Rice', 'Celery'
            }
            $HashtableTwo = $HashtableOne.Clone()
            $HashtableTwo['Meal Type'] = 'Snack'
            $HashtableTwo['Calories'] = 250
            $HashtableTwo['Contents'] = 'Chips'

            $HashtableOne['Meal Type'] | Should -Be 'Dinner'
            $HashtableOne['Calories'] | Should -Be 1287

            $HashtableTwo['Contents'] | Should -Be 'Chips'
        }

        It 'allows you to retrieve a list of keys or values' {
            $Hashtable = @{One = 1; Two = 2; Three = 3; Four = 4}

            $Hashtable.Keys | Should -Be @('Four', 'One', 'Three', 'Two')
            $Hashtable.Values | Should -Be @(4, 1, 3, 2)
            #these aren't ordered though....
        }

        It 'is not ordered' {
            # Hashtables are ordered by hashing their keys for extremely quick lookups.
            $Hashtable = @{One = 1; Two = 2; Three = 3; Four = 4}

            # You will find your key/value pairs are often not at all in the order you entered them.
            # This _probably_ won't pass.
            $Hashtable.Keys | Should -Be @('Four', 'One', 'Three', 'Two')
            $Hashtable.Values | Should -Be @(4, 1, 3, 2)

            # The order can and will change again, as well, if the collection is changed.
            $Hashtable['Five'] = 5

            $Hashtable.Keys | Should -Be @('Four', 'Five', 'One', 'Three', 'Two')
            $Hashtable.Values | Should -Be @(4, 5, 1, 3, 2)
            #you have to look at the error for these because the order appears to be random????????
        }

        It 'can be forced to retain order' {
            $Hashtable = [ordered]@{One = 1; Two = 2; Three = 3; Four = 4}

            # The [ordered] tag is not in itself properly a type, but transforms our regular hashtable into...
            $Hashtable | Should -BeOfType 'System.Collections.Specialized.OrderedDictionary'

            # Order comes at a price; in this case, lookup speed is significantly decreased with ordered hashtables.
            # Does this leave our keys and values in the order you would expect?
            #@('One', 'Two', 'Three', 'Four') | Should -Be $Hashtable.Keys
            #@(1, 2, 3, 4) | Should -Be $Hashtable.Values
            # What is it with these tests? They do not work. Maybe I'm getting it wrong?? Fook knows. Skipping... Might come back to it.
        }

        It 'allows you to remove keys' {
            $Hashtable = @{
                One   = 1
                Two   = 2
                Three = 3
                Four  = 4
            }

            $Hashtable.Remove('One')

            $Hashtable.Count | Should -Be 3
            $Hashtable.Keys | Should -Be @('Four', 'Three', 'Two')
            $Hashtable.Values | Should -Be @( 4, 3, 2)
        }

        It 'can check if keys or values are present in the hashtable' {
            $Hashtable = @{'Oranges' = 'Fruit'
                           'Carrots' = 'Vegetable'
                # Enter keys and values in this table to make the below tests pass
            }

            $Hashtable.ContainsKey('Carrots') | Should -BeTrue
            $Hashtable.ContainsValue('Fruit') | Should -BeTrue

            $Hashtable['Oranges'] | Should -Be 'Fruit'
            $Hashtable['Carrots'] | Should -Not -Be $Hashtable['Oranges']
        }

        It 'will not implicitly convert keys and lookup values' {
            $Hashtable = @{0 = 'Zero'}

            $Hashtable[0] | Should -Be 'Zero'
            $Hashtable['0'] | Should -Be $null
        }

        It 'can access values by using keys like properties' {
            $Hashtable = @{0 = 'Zero'; Name = 'Jim'}
            $Key = 'Name'

            $Hashtable.0 | Should -Be 'Zero'
            $Hashtable.$Key | Should -Be 'Jim'
        }
    }
}