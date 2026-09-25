Describe "Maester/Entra" -Tag "Maester", "Entra", "GuestAccess" {
    It "MT.1245: Guest users should not own applications in the tenant. See https://maester.dev/docs/tests/MT.1245" -Tag "MT.1245" {
        $result = Test-MtGuestAppOwnership
        $result | Should -Be $true -Because "Guest users should not own applications as this could lead to unauthorized access or privilege escalation. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#guests-dont-own-apps-in-the-tenant"
    }
}