Describe "Maester/Entra" -Tag "Maester", "Entra", "Authentication" {
    It "MT.1236: Cloud authentication should be enforced (no federated domains). See https://maester.dev/docs/tests/MT.1236" -Tag "MT.1236" {
        $result = Test-MtCloudAuthenticationEnforced
        $result | Should -Be $true -Because "Federated domains use on-premises identity providers which can introduce security risks if compromised. Cloud authentication (managed domains) is recommended. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#use-cloud-authentication"
    }
}