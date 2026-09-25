Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "TLSInspection" {
    It "MT.1252: TLS inspection failure rate should be below 1%. See https://maester.dev/docs/tests/MT.1252" -Tag "MT.1252" {
        $result = Test-MtGsaTlsInspectionFailureRate
        $result | Should -Be $true -Because "High TLS inspection failure rates can indicate configuration issues. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#tls-inspection-failure-rate-is-below-1"
    }
}