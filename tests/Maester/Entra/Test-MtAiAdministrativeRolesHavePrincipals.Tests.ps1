Describe "Maester/Entra" -Tag "Maester", "Entra", "AI" {
    It "MT.1276: AI administrative roles should have assigned principals. See https://maester.dev/docs/tests/MT.1276" -Tag "MT.1276" {
        $result = Test-MtAiAdministrativeRolesHavePrincipals
        $result | Should -Be $true -Because "AI administrative roles should have assigned principals for accountability. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#ai-administrative-roles-have-assigned-principals"
    }
}