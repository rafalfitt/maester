Describe "Maester/Entra" -Tag "Maester", "Entra", "SSPR" {
    It "MT.1234: Administrators should be blocked from using SSPR. See https://maester.dev/docs/tests/MT.1234" -Tag "MT.1234" {
        $result = Test-MtBlockAdminsFromSspr
        $result | Should -Be $true -Because "Administrators should be blocked from using Self-Service Password Reset (SSPR) to prevent attackers from resetting passwords on compromised admin accounts. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#block-administrators-from-using-sspr"
    }
}