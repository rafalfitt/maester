Describe "Maester/Entra" -Tag "Maester", "Entra", "IdentityProtection", "WorkloadIdentity" {
    It "MT.1271: All risky workload identities should be triaged. See https://maester.dev/docs/tests/MT.1271" -Tag "MT.1271" {
        $result = Test-MtRiskyWorkloadIdentitiesTriaged
        $result | Should -Be $true -Because "All risky workload identities should be investigated and triaged. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#all-risky-workload-identities-are-triaged"
    }
}