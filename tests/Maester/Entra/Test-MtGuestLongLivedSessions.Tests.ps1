Describe "Maester/Entra" -Tag "Maester", "Entra", "GuestAccess" {
    It "MT.1244: Guest users should not have long-lived sign-in sessions. See https://maester.dev/docs/tests/MT.1244" -Tag "MT.1244" {
        $result = Test-MtGuestLongLivedSessions
        $result | Should -Be $true -Because "Guest users should have sign-in frequency or persistent browser session controls configured to limit session duration. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#guests-dont-have-long-lived-sign-in-sessions"
    }
}