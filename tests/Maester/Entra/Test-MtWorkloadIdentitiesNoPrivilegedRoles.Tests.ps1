Describe "Maester/Entra" -Tag "Maester", "Entra", "AppSecurity", "WorkloadIdentity" {
    It "MT.1269: Workload identities should not be assigned privileged roles. See https://maester.dev/docs/tests/MT.1269" -Tag "MT.1269" {
        $result = Test-MtWorkloadIdentitiesNoPrivilegedRoles
        $result | Should -Be $true -Because "Workload identities (service principals, managed identities) should not be assigned privileged directory roles. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#workload-identities-are-not-assigned-privileged-roles"
    }
}