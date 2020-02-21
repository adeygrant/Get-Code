function Start-Bitlocker {
    <#
        .Synopsis
        This function enables Bitlocker.
        .Description
        This functions enables Bitlocker on C:. Protectors are TPMandPIN,
        plus a recovery key. It suspends Bitlocker post enable to allow
        the completion of imaging etc.
        .Example
        Start-Bitlocker -pin "asupersecurepassword"
        .Notes
        notes
        .Link
        https://docs.microsoft.com/en-us/powershell/module/bitlocker/?view=win10-ps
    #>
    [CmdletBinding()]
    param(
        # This parameter is the password / pin used to unlock the disk.
        [Parameter(Mandatory=$true)]
        [securestring]$pin
    )

    $BitlockerParams = @{
        MountPoint         = "C:"
        EncryptionMethod   = "Aes256"
        Pin                = $pin
        UsedSpaceOnly      = $true
        TpmAndPinProtector = $true
        SkipHardwareTest   = $true
    }

    Enable-BitLocker @BitlockerParams

    Add-BitLockerKeyProtector -MountPoint "C:" -RecoveryPasswordProtector

    Suspend-BitLocker -MountPoint "C:" -RebootCount 2
}

$pin = ConvertTo-SecureString "asupersecurepassword" -asplaintext -force

Start-Bitlocker -pin $pin
