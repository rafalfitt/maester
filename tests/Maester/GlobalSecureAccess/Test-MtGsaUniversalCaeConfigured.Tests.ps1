Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "CAE" {
    It "MT.1258: Network validation should be configured through Universal Continuous Access Evaluation. See https://maester.dev/docs/tests/MT.1258" -Tag "MT.1258" {
        $result = Test-MtGsaUniversalCaeConfigured
        $result | Should -Be $true -Because "Universal CAE provides real-time token validation for network validation. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#network-validation-is-configured-through-universal-continuous-access-evaluation"
    }
}