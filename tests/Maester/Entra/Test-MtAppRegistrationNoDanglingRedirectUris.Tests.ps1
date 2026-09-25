Describe "Maester/Entra" -Tag "Maester", "Entra", "AppSecurity" {
    It "MT.1267: App registrations should not have dangling or abandoned domain redirect URIs. See https://maester.dev/docs/tests/MT.1267" -Tag "MT.1267" {
        $result = Test-MtAppRegistrationNoDanglingRedirectUris
        $result | Should -Be $true -Because "App registrations should not have redirect URIs pointing to domains that no longer exist or are not controlled by the organization. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#app-registrations-must-not-have-dangling-or-abandoned-domain-redirect-uris"
    }
}