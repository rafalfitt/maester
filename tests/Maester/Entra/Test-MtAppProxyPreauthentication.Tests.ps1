Describe "Maester/Entra" -Tag "Maester", "Entra", "AppProxy" {
    It "MT.1232: Application Proxy applications should require preauthentication. See https://maester.dev/docs/tests/MT.1232" -Tag "MT.1232" {
        $result = Test-MtAppProxyPreauthentication
        $result | Should -Be $true -Because "Application Proxy applications should require Entra ID preauthentication to block anonymous access to on-premises applications. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#application-proxy-applications-require-preauthentication-to-block-anonymous-access"
    }
}