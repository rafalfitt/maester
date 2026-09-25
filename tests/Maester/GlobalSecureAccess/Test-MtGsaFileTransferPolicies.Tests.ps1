Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "DataProtection" {
    It "MT.1254: File transfer policies should be configured to prevent data exfiltration. See https://maester.dev/docs/tests/MT.1254" -Tag "MT.1254" {
        $result = Test-MtGsaFileTransferPolicies
        $result | Should -Be $true -Because "File transfer policies can prevent data exfiltration by controlling file uploads/downloads. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#file-transfer-policies-are-configured-to-prevent-data-exfiltration"
    }
}