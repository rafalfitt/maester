Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "TenantRestrictions" {
    It "MT.1259: Universal tenant restrictions should block unauthorized external tenant access. See https://maester.dev/docs/tests/MT.1259" -Tag "MT.1259" {
        $result = Test-MtGsaUniversalTenantRestrictions
        $result | Should -Be $true -Because "Universal tenant restrictions should block unauthorized external tenant access. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#universal-tenant-restrictions-block-unauthorized-external-tenant-access"
    }
}