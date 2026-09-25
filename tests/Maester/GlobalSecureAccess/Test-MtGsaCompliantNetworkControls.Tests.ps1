Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "CA" {
    It "MT.1260: Conditional Access policies should use compliant network controls. See https://maester.dev/docs/tests/MT.1260" -Tag "MT.1260" {
        $result = Test-MtGsaCompliantNetworkControls
        $result | Should -Be $true -Because "CA policies should reference GSA compliant network for access decisions. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#conditional-access-policies-use-compliant-network-controls"
    }
}