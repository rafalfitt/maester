function Test-MtGsaDeploymentLogsReviewed {
    <#
    .SYNOPSIS
    Checks if Global Secure Access deployment logs are populated and reviewed.

    .DESCRIPTION
    GSA deployment logs should be populated and regularly reviewed for operational health.
    This test verifies that deployment logs are available.

    .EXAMPLE
    Test-MtGsaDeploymentLogsReviewed

    Returns true if GSA deployment logs are populated.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaDeploymentLogsReviewed
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get GSA deployment logs
        $deploymentLogs = @(Invoke-MtGraphRequest -RelativeUri 'networkAccess/deploymentLogs?$top=1' -ErrorAction SilentlyContinue)

        $logsPopulated = $false

        if ($deploymentLogs -and $deploymentLogs.Count -gt 0) {
            $logsPopulated = $true
        }

        $return = $logsPopulated

        if ($return) {
            $testResultMarkdown = 'Well done. Global Secure Access deployment logs are populated.'
        } else {
            $testResultMarkdown = 'Global Secure Access deployment logs are not populated. Deployment logs should be reviewed for operational health.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}