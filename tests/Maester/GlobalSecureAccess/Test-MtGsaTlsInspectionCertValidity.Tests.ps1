Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "TLSInspection" {
    It "MT.1251: TLS inspection certificates should have sufficient validity period. See https://maester.dev/docs/tests/MT.1251" -Tag "MT.1251" {
        $result = Test-MtGsaTlsInspectionCertValidity -MinDaysValid 30
        $result | Should -Be $true -Because "TLS inspection certificates should have sufficient validity period to avoid service disruption. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#tls-inspection-certificates-have-a-sufficient-validity-period"
    }
}