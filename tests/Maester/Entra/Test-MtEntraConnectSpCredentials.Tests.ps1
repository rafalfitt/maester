Describe "Maester/Entra" -Tag "Maester", "Entra", "EntraConnect" {
    It "MT.1239: Entra Connect Sync should use Service Principal credentials. See https://maester.dev/docs/tests/MT.1239" -Tag "MT.1239" {
        $result = Test-MtEntraConnectSpCredentials
        $result | Should -Be $true -Because "Entra Connect Sync should use a Service Principal with certificate-based authentication instead of a user account with password. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#entra-connect-sync-is-configured-with-service-principal-credentials"
    }
}