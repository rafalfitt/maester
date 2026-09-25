Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "TLSInspection" {
    It "MT.1253: TLS inspection custom bypass rules should not duplicate system bypass destinations. See https://maester.dev/docs/tests/MT.1253" -Tag "MT.1253" {
        $result = Test-MtGsaTlsInspectionBypassNoDuplicates
        $result | Should -Be $true -Because "Custom bypass rules should not duplicate system bypass destinations. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#tls-inspection-custom-bypass-rules-dont-duplicate-system-bypass-destinations"
    }
}