function Test-MtGsaM365TrafficFlowing {
    <#
    .SYNOPSIS
    Checks if Microsoft 365 traffic is actively flowing through Global Secure Access.

    .DESCRIPTION
    M365 traffic should flow through GSA for security policy enforcement.
    This test verifies that M365 traffic is being routed through GSA.

    .EXAMPLE
    Test-MtGsaM365TrafficFlowing

    Returns true if M365 traffic is flowing through GSA.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaM365TrafficFlowing
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get GSA traffic metrics for M365
        $trafficMetrics = Invoke-MtGraphRequest -RelativeUri 'networkAccess/trafficMetrics?$filter=service eq \'Microsoft365\'' -ErrorAction SilentlyContinue

        $trafficFlowing = $false

        if ($trafficMetrics -and $trafficMetrics.value) {
            foreach ($metric in $trafficMetrics.value) {
                if ($metric.bytesTransferred -gt 0) {
                    $trafficFlowing = $true
                    break
                }
            }
        }

        $return = $trafficFlowing

        if ($return) {
            $testResultMarkdown = 'Well done. Microsoft 365 traffic is actively flowing through Global Secure Access.'
        } else {
            $testResultMarkdown = 'Microsoft 365 traffic is not flowing through Global Secure Access. M365 traffic should be routed through GSA for security policy enforcement.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}