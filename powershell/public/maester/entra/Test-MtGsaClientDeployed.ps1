function Test-MtGsaClientDeployed {
    <#
    .SYNOPSIS
    Checks if Global Secure Access client is deployed on all managed endpoints.

    .DESCRIPTION
    The GSA client should be deployed on all managed endpoints for network traffic inspection.
    This test verifies that the client is deployed.

    .EXAMPLE
    Test-MtGsaClientDeployed

    Returns true if GSA client is deployed on managed endpoints.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaClientDeployed
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get GSA client deployment status
        $clientDeployment = Invoke-MtGraphRequest -RelativeUri 'networkAccess/clientDeploymentStatus' -ErrorAction SilentlyContinue

        $deployed = $false

        if ($clientDeployment -and $clientDeployment.deploymentStatus -eq 'deployed') {
            $deployed = $true
        }

        $return = $deployed

        if ($return) {
            $testResultMarkdown = 'Well done. Global Secure Access client is deployed on managed endpoints.'
        } else {
            $testResultMarkdown = 'Global Secure Access client is not deployed on all managed endpoints. The client is required for network traffic inspection.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}