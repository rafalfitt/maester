Describe "Maester/Entra" -Tag "Maester", "Entra", "EntraConnect" {
    It "MT.1262: Legacy Entra Connect user-type service accounts with high privileges should not exist. See https://maester.dev/docs/tests/MT.1262" -Tag "MT.1262" {
        $result = Test-MtEntraConnectLegacyServiceAccounts
        $result | Should -Be $true -Because "Legacy Entra Connect user-type service accounts with high privileges should be migrated to Service Principal-based authentication. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#entra-connect-sync-is-configured-with-service-principal-credentials"
    }
}