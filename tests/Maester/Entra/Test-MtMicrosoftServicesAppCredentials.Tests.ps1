Describe "Maester/Entra" -Tag "Maester", "Entra", "AppSecurity" {
    It "MT.1230: Microsoft first-party service principals should not have credentials configured. See https://maester.dev/docs/tests/MT.1230" -Tag "MT.1230" {
        $result = Test-MtMicrosoftServicesAppCredentials
        $result | Should -Be $true -Because "Microsoft first-party service principals should not have client secrets or certificates configured as they are managed by Microsoft. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#microsoft-services-applications-dont-have-credentials-configured"
    }
}