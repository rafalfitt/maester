Describe "Maester/Entra" -Tag "Maester", "Entra", "CA", "PrivateAccess" {
    It "MT.1231: Conditional Access policies should enforce strong authentication for private apps. See https://maester.dev/docs/tests/MT.1231" -Tag "MT.1231" {
        $result = Test-MtCaPrivateAppsStrongAuth
        $result | Should -Be $true -Because "Conditional Access policies should require phishing-resistant MFA for access to private apps published through Entra Private Access. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#conditional-access-policies-enforce-strong-authentication-for-private-apps"
    }
}