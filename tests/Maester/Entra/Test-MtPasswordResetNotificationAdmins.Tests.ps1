Describe "Maester/Entra" -Tag "Maester", "Entra", "SSPR" {
    It "MT.1233: Password reset notifications should be enabled for administrators. See https://maester.dev/docs/tests/MT.1233" -Tag "MT.1233" {
        $result = Test-MtPasswordResetNotificationAdmins
        $result | Should -Be $true -Because "Password reset notifications should be enabled for both administrators and users to detect unauthorized password resets on privileged accounts. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#require-password-reset-notifications-for-administrator-roles"
    }
}