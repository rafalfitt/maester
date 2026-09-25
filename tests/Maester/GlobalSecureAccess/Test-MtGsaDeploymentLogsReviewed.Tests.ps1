Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "Logging" {
    It "MT.1274: Global Secure Access deployment logs should be populated and reviewed. See https://maester.dev/docs/tests/MT.1274" -Tag "MT.1274" {
        $result = Test-MtGsaDeploymentLogsReviewed
        $result | Should -Be $true -Because "GSA deployment logs should be populated and reviewed for operational health. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#global-secure-access-deployment-logs-are-populated-and-reviewed"
    }
}