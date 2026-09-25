Describe "Maester/Entra" -Tag "Maester", "Entra", "TenantRestrictions" {
    It "MT.1249: Tenant Restrictions v2 policy should be configured. See https://maester.dev/docs/tests/MT.1249" -Tag "MT.1249" {
        $result = Test-MtTenantRestrictionsV2Configured
        $result | Should -Be $true -Because "Tenant Restrictions v2 controls which tenants users can access and should be configured. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#tenant-restrictions-v2-policy-is-configured"
    }
}