Describe "Maester/Entra" -Tag "Maester", "Entra", "IdentityProtection" {
    It "MT.1272: ID Protection notifications should be enabled. See https://maester.dev/docs/tests/MT.1272" -Tag "MT.1272" {
        $result = Test-MtIdProtectionNotificationsEnabled
        $result | Should -Be $true -Because "ID Protection notifications should be enabled to alert administrators of identity risks. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#id-protection-notifications-are-enabled"
    }
}