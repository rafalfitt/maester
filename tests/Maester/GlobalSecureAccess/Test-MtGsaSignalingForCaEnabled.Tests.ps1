Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "CA" {
    It "MT.1261: Global Secure Access signaling for Conditional Access should be enabled. See https://maester.dev/docs/tests/MT.1261" -Tag "MT.1261" {
        $result = Test-MtGsaSignalingForCaEnabled
        $result | Should -Be $true -Because "GSA signaling allows CA policies to receive real-time network signals from GSA. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#global-secure-access-signaling-for-conditional-access-is-enabled"
    }
}