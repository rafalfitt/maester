Describe "Maester/Entra" -Tag "Maester", "Entra", "TokenProtection" {
    It "MT.1237: Token protection policies should be configured. See https://maester.dev/docs/tests/MT.1237" -Tag "MT.1237" {
        $result = Test-MtTokenProtectionPolicyEnabled
        $result | Should -Be $true -Because "Token protection binds sign-in tokens to the device, preventing token theft and replay attacks. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#token-protection-policies-are-configured"
    }
}