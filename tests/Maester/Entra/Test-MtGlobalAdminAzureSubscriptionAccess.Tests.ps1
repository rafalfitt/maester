Describe "Maester/Entra" -Tag "Maester", "Entra", "PIM", "Azure" {
    It "MT.1264: Global Administrators should not have standing access to Azure subscriptions. See https://maester.dev/docs/tests/MT.1264" -Tag "MT.1264" {
        $result = Test-MtGlobalAdminAzureSubscriptionAccess
        # This test requires Azure ARM API access, so it may return null
        if ($null -ne $result) {
            $result | Should -Be $true -Because "Global Administrators should not have standing access to Azure subscriptions. Access should be granted through PIM or just-in-time. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#global-administrators-dont-have-standing-access-to-azure-subscriptions"
        }
    }
}