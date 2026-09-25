function Test-MtGsaSwgAllLayersInspected {
    <#
    .SYNOPSIS
    Checks if internet traffic is inspected across all Secure Web Gateway defense layers.

    .DESCRIPTION
    Internet traffic should be inspected across all SWG defense layers (URL filtering, malware scanning, etc.).
    This test verifies that all layers are enabled.

    .EXAMPLE
    Test-MtGsaSwgAllLayersInspected

    Returns true if all SWG defense layers are inspecting traffic.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaSwgAllLayersInspected
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get GSA SWG configuration
        $swgConfig = Invoke-MtGraphRequest -RelativeUri 'networkAccess/secureWebGateway' -ErrorAction SilentlyContinue

        $allLayersEnabled = $true
        $disabledLayers = @()

        if ($swgConfig) {
            # Check URL filtering
            if ($swgConfig.urlFiltering -and $swgConfig.urlFiltering.isEnabled -ne $true) {
                $allLayersEnabled = $false
                $disabledLayers += 'URL Filtering'
            }

            # Check malware scanning
            if ($swgConfig.malwareScanning -and $swgConfig.malwareScanning.isEnabled -ne $true) {
                $allLayersEnabled = $false
                $disabledLayers += 'Malware Scanning'
            }

            # Check TLS inspection
            if ($swgConfig.tlsInspection -and $swgConfig.tlsInspection.isEnabled -ne $true) {
                $allLayersEnabled = $false
                $disabledLayers += 'TLS Inspection'
            }

            # Check threat intelligence
            if ($swgConfig.threatIntelligence -and $swgConfig.threatIntelligence.isEnabled -ne $true) {
                $allLayersEnabled = $false
                $disabledLayers += 'Threat Intelligence'
            }
        } else {
            $allLayersEnabled = $false
            $disabledLayers += 'SWG not configured'
        }

        $return = $allLayersEnabled

        if ($return) {
            $testResultMarkdown = 'Well done. Internet traffic is inspected across all Secure Web Gateway defense layers.'
        } else {
            $testResultMarkdown = "The following SWG defense layers are not enabled: $($disabledLayers -join ', ')."
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}