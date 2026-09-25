Describe "Maester/Entra" -Tag "Maester", "Entra", "Authentication" {
    It "MT.1241: No ADAL usage should be detected in the tenant. See https://maester.dev/docs/tests/MT.1241" -Tag "MT.1241" {
        $result = Test-MtAdalUsageDetected
        $result | Should -Be $true -Because "ADAL (Azure AD Authentication Library) has been deprecated and replaced by MSAL. Applications should be migrated to MSAL. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#no-usage-of-adal-in-the-tenant"
    }
}