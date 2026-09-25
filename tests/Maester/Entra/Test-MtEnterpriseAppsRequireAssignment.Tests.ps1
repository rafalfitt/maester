Describe "Maester/Entra" -Tag "Maester", "Entra", "AppSecurity" {
    It "MT.1270: Enterprise applications should require explicit assignment or scoped provisioning. See https://maester.dev/docs/tests/MT.1270" -Tag "MT.1270" {
        $result = Test-MtEnterpriseAppsRequireAssignment
        $result | Should -Be $true -Because "Enterprise applications should require explicit user assignment or scoped provisioning to prevent unauthorized access. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#enterprise-applications-must-require-explicit-assignment-or-scoped-provisioning"
    }
}