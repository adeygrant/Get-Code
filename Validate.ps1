#https://medium.com/@cjkuech/defensive-powershell-with-validation-attributes-8e7303e179fd

# Ensure a path exists
[ValidateScript({Test-Path $_})]
$path

# Ensure a non-empty value
[ValidateNotNullOrEmpty()]
$value

# Ensure a string meets a certain convention
[ValidatePattern("^[a-z]+-[a-z]+-[a-z]+-[0-9]+$")]
$identifier

# Ensure a string is a predefined symbol
[ValidateSet("DEV", "INT", "TEST", "STAGE", "CANARY", "PROD")]
$flightingRing
