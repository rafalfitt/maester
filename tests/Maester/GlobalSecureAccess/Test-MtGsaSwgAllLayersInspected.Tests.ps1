Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "SWG" {
    It "MT.1257: Internet traffic should be inspected across all Secure Web Gateway defense layers. See https://maester.dev/docs/tests/MT.1257" -Tag "MT.1257" {
        $result = Test-MtGsaSwgAllLayersInspected
        $result | Should -Be $true -Because "Internet traffic should be inspected across all SWG defense layers (URL filtering, malware scanning, TLS inspection, threat intelligence). See https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#internet-traffic-is-inspected-across-all-secure-web-gateway-defense-layers"
    }
}