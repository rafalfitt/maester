Describe "Maester/Entra" -Tag "Maester", "Entra", "GuestAccess" {
    It "MT.1247: Inactive guest identities should be disabled or removed. See https://maester.dev/docs/tests/MT.1247" -Tag "MT.1247" {
        $result = Test-MtInactiveGuestCleanup -InactiveDays 90
        $result | Should -Be $true -Because "Inactive guest users should be disabled or removed to reduce the attack surface. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#inactive-guest-identities-are-disabled-or-removed-from-the-tenant"
    }
}