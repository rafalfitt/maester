Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "Traffic" {
    It "MT.1217: Microsoft 365 traffic should be actively flowing through Global Secure Access. See https://maester.dev/docs/tests/MT.1217" -Tag "MT.1217" {
        $result = Test-MtGsaM365TrafficFlowing
        $result | Should -Be $true -Because "M365 traffic should be routed through GSA for security policy enforcement."
    }
}