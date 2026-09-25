Describe "Maester/Entra" -Tag "Maester", "Entra", "EntraConnect" {
    It "MT.1240: Directory sync account should be locked down to specific named location. See https://maester.dev/docs/tests/MT.1240" -Tag "MT.1240" {
        $result = Test-MtDirectorySyncAccountNamedLocation
        $result | Should -Be $true -Because "The directory synchronization account should only be allowed to sign in from specific named locations (IP ranges) to prevent unauthorized access. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#directory-sync-account-is-locked-down-to-specific-named-location"
    }
}