Describe "Maester/Entra" -Tag "Maester", "Entra", "IdentityProtection", "WorkloadIdentity" {
    It "MT.1275: Workload identities should be configured with risk-based policies. See https://maester.dev/docs/tests/MT.1275" -Tag "MT.1275" {
        $result = Test-MtWorkloadIdentitiesRiskBasedPolicies
        $result | Should -Be $true -Because "Workload identities should have risk-based Conditional Access policies configured to automatically respond to risk events. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#workload-identities-are-configured-with-risk-based-policies"
    }
}