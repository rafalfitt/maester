Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "Licensing" {
    It "MT.1216: Global Secure Access licenses should be available and assigned to users. See https://maester.dev/docs/tests/MT.1216" -Tag "MT.1216" {
        $result = Test-MtGsaLicensesAssigned
        $result | Should -Be $true -Because "GSA licenses must be available and assigned to users for the service to function."
    }
}