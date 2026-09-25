Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "AIGateway" {
    It "MT.1255: AI Gateway should be configured to protect enterprise generative AI applications. See https://maester.dev/docs/tests/MT.1255" -Tag "MT.1255" {
        $result = Test-MtGsaAiGatewayConfigured
        $result | Should -Be $true -Because "AI Gateway protects enterprise generative AI applications from prompt injection attacks. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#ai-gateway-protects-enterprise-generative-ai-applications-from-prompt-injection-attacks"
    }
}