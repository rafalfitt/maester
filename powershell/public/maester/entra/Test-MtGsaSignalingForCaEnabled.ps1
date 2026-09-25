function Test-MtGsaSignalingForCaEnabled {
    <#
    .SYNOPSIS
    Checks if Global Secure Access signaling for Conditional Access is enabled.

    .DESCRIPTION
    GSA signaling allows CA policies to receive real-time network signals from GSA.
    This test verifies that GSA signaling for CA is enabled.

    .EXAMPLE
    Test-MtGsaSignalingForCaEnabled

    Returns true if GSA signaling for CA is enabled.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaSignalingForCaEnabled
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get GSA signaling configuration
        $signaling = Invoke-MtGraphRequest -RelativeUri 'networkAccess/conditionalAccessSignaling' -ErrorAction SilentlyContinue

        $enabled = $false

        if ($signaling -and $signaling.isEnabled -eq $true) {
            $enabled = $true
        }

        $return = $enabled

        if ($return) {
            $testResultMarkdown = 'Well done. Global Secure Access signaling for Conditional Access is enabled.'
        } else {
            $testResultMarkdown = 'Global Secure Access signaling for Conditional Access is not enabled. It allows CA policies to receive real-time network signals from GSA.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}