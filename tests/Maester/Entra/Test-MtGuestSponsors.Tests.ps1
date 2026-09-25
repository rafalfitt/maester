Describe "Maester/Entra" -Tag "Maester", "Entra", "GuestAccess" {
    It "MT.1246: All guest users should have a sponsor assigned. See https://maester.dev/docs/tests/MT.1246" -Tag "MT.1246" {
        $result = Test-MtGuestSponsors
        $result | Should -Be $true -Because "All guest users should have a sponsor assigned for accountability and access reviews. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#all-guests-have-a-sponsor"
    }
}