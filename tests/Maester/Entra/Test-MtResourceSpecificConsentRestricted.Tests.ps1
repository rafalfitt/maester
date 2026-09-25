Describe "Maester/Entra" -Tag "Maester", "Entra", "AppSecurity" {
    It "MT.1268: Resource-specific consent should be restricted. See https://maester.dev/docs/tests/MT.1268" -Tag "MT.1268" {
        $result = Test-MtResourceSpecificConsentRestricted
        $result | Should -Be $true -Because "Resource-specific consent should be restricted to prevent unauthorized access. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#resource-specific-consent-is-restricted"
    }
}