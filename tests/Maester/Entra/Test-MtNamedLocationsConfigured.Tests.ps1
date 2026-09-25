Describe "Maester/Entra" -Tag "Maester", "Entra", "CA", "NamedLocations" {
    It "MT.1248: Named locations should be configured. See https://maester.dev/docs/tests/MT.1248" -Tag "MT.1248" {
        $result = Test-MtNamedLocationsConfigured
        $result | Should -Be $true -Because "Named locations define trusted IP ranges or countries for use in Conditional Access policies. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#named-locations-are-configured"
    }
}