function Test-MtGsaAiGatewayConfigured {
    <#
    .SYNOPSIS
    Checks if AI Gateway is configured to protect enterprise generative AI applications.

    .DESCRIPTION
    AI Gateway protects enterprise generative AI applications from prompt injection attacks.
    This test verifies that AI Gateway is configured.

    .EXAMPLE
    Test-MtGsaAiGatewayConfigured

    Returns true if AI Gateway is configured.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaAiGatewayConfigured
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get GSA AI Gateway configuration
        $aiGateway = Invoke-MtGraphRequest -RelativeUri 'networkAccess/aiGateway' -ErrorAction SilentlyContinue

        $configured = $false

        if ($aiGateway -and $aiGateway.isEnabled -eq $true) {
            $configured = $true
        }

        $return = $configured

        if ($return) {
            $testResultMarkdown = 'Well done. AI Gateway is configured to protect enterprise generative AI applications.'
        } else {
            $testResultMarkdown = 'AI Gateway is not configured. AI Gateway protects enterprise generative AI applications from prompt injection attacks.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}