Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "TLSInspection" {
    It "MT.1250: TLS inspection bypass rules should be regularly reviewed. See https://maester.dev/docs/tests/MT.1250" -Tag "MT.1250" {
        $result = Test-MtGsaTlsInspectionBypassReviewed -MaxDaysSinceReview 90
        $result | Should -Be $true -Because "TLS inspection bypass rules should be regularly reviewed to ensure they are still necessary. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#tls-inspection-bypass-rules-are-regularly-reviewed"
    }
}