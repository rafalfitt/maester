Describe "Maester/GlobalSecureAccess" -Tag "Maester", "GSA", "Client" {
    It "MT.1215: Global Secure Access client should be deployed on all managed endpoints. See https://maester.dev/docs/tests/MT.1215" -Tag "MT.1215" {
        $result = Test-MtGsaClientDeployed
        $result | Should -Be $true -Because "The GSA client is required for network traffic inspection on managed endpoints."
    }
}