Describe "Maester/Entra" -Tag "Maester", "Entra", "AppSecurity" {
    It "MT.1265: App registrations should use safe redirect URIs. See https://maester.dev/docs/tests/MT.1265" -Tag "MT.1265" {
        $result = Test-MtAppRegistrationSafeRedirectUris
        $result | Should -Be $true -Because "App registrations should not use insecure redirect URIs (HTTP non-localhost, wildcards). See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#app-registrations-use-safe-redirect-uris"
    }
}