Describe "Maester/Entra" -Tag "Maester", "Entra", "Authentication" {
    It "MT.1238: User-visible password surface area should be reduced. See https://maester.dev/docs/tests/MT.1238" -Tag "MT.1238" {
        $result = Test-MtReducePasswordSurfaceArea
        $result | Should -Be $true -Because "Password hash synchronization should be enabled and password writeback disabled to reduce the attack surface for password-based attacks. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#reduce-the-user-visible-password-surface-area"
    }
}