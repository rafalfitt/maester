Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "Logging" {
    It "MT.1273: Network access logs should be retained for security analysis and compliance. See https://maester.dev/docs/tests/MT.1273" -Tag "MT.1273" {
        $result = Test-MtNetworkAccessLogsRetained
        $result | Should -Be $true -Because "Network access logs should be retained for security analysis and compliance requirements. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#network-access-logs-are-retained-for-security-analysis-and-compliance-requirements"
    }
}