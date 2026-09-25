Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "CloudFirewall" {
    It "MT.1256: Global Secure Access cloud firewall should protect branch office internet traffic. See https://maester.dev/docs/tests/MT.1256" -Tag "MT.1256" {
        $result = Test-MtGsaCloudFirewallConfigured
        $result | Should -Be $true -Because "The GSA cloud firewall protects branch office internet traffic. See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#global-secure-access-cloud-firewall-protects-branch-office-internet-traffic"
    }
}