Describe "Maester/Entra" -Tag "Maester", "Entra", "PIM" {
    It "MT.1263: Global Administrator role activation should trigger an approval workflow. See https://maester.dev/docs/tests/MT.1263" -Tag "MT.1263" {
        $result = Test-MtGlobalAdminActivationApproval
        $result | Should -Be $true -Because "Global Administrator role activations should require approval through PIM. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#global-administrator-role-activation-triggers-an-approval-workflow"
    }
}