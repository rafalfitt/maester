Describe "Maester/Entra" -Tag "Maester", "Entra", "CA", "ProtectedActions" {
    It "MT.1242: Protected actions should be enabled for Conditional Access policy changes. See https://maester.dev/docs/tests/MT.1242" -Tag "MT.1242" {
        $result = Test-MtProtectedActionsForCaChanges
        $result | Should -Be $true -Because "Protected actions require additional authentication before allowing changes to Conditional Access policies, preventing unauthorized modifications. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#enable-protected-actions-to-secure-conditional-access-policy-creation-and-changes"
    }
}