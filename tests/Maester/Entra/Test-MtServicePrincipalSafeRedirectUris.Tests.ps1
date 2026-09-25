Describe "Maester/Entra" -Tag "Maester", "Entra", "AppSecurity" {
    It "MT.1266: Service principals should use safe redirect URIs. See https://maester.dev/docs/tests/MT.1266" -Tag "MT.1266" {
        $result = Test-MtServicePrincipalSafeRedirectUris
        $result | Should -Be $true -Because "Service principals should not use insecure redirect URIs (HTTP non-localhost, wildcards). See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#service-principals-use-safe-redirect-uris"
    }
}