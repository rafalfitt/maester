function Test-MtGsaCloudFirewallConfigured {
    <#
    .SYNOPSIS
    Checks if Global Secure Access cloud firewall protects branch office internet traffic.

    .DESCRIPTION
    The GSA cloud firewall protects branch office internet traffic. This test verifies
    that the cloud firewall is configured and enabled.

    .EXAMPLE
    Test-MtGsaCloudFirewallConfigured

    Returns true if GSA cloud firewall is configured.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaCloudFirewallConfigured
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get GSA cloud firewall configuration
        $firewall = Invoke-MtGraphRequest -RelativeUri 'networkAccess/cloudFirewall' -ErrorAction SilentlyContinue

        $configured = $false

        if ($firewall -and $firewall.isEnabled -eq $true) {
            $configured = $true
        }

        $return = $configured

        if ($return) {
            $testResultMarkdown = 'Well done. Global Secure Access cloud firewall is configured and protecting branch office traffic.'
        } else {
            $testResultMarkdown = 'Global Secure Access cloud firewall is not configured. It protects branch office internet traffic.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}