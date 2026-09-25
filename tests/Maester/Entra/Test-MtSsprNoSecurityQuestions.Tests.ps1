Describe "Maester/Entra" -Tag "Maester", "Entra", "SSPR" {
    It "MT.1235: SSPR should not use security questions. See https://maester.dev/docs/tests/MT.1235" -Tag "MT.1235" {
        $result = Test-MtSsprNoSecurityQuestions
        $result | Should -Be $true -Because "Security questions are a weak authentication method for password reset and should be disabled in SSPR policy. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#self-service-password-reset-doesnt-use-security-questions"
    }
}