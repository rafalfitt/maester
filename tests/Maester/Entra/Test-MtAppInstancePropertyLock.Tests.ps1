Describe "Maester/Entra" -Tag "Maester", "Entra", "AppSecurity" {
    It "MT.1243: App instance property lock should be configured for all multitenant applications. See https://maester.dev/docs/tests/MT.1243" -Tag "MT.1243" {
        $result = Test-MtAppInstancePropertyLock
        $result | Should -Be $true -Because "App instance property lock prevents unauthorized changes to multitenant application properties by locking them to the home tenant. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#app-instance-property-lock-is-configured-for-all-multitenant-applications"
    }
}