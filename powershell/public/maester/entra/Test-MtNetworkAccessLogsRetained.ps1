function Test-MtNetworkAccessLogsRetained {
    <#
    .SYNOPSIS
    Checks if network access logs are retained for security analysis and compliance.

    .DESCRIPTION
    Network access logs from Global Secure Access should be retained for security analysis
    and compliance requirements. This test verifies that log retention is configured.

    .EXAMPLE
    Test-MtNetworkAccessLogsRetained

    Returns true if network access logs are retained.

    .LINK
    https://maester.dev/docs/commands/Test-MtNetworkAccessLogsRetained
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get GSA log retention settings
        $logSettings = Invoke-MtGraphRequest -RelativeUri 'networkAccess/logRetentionSettings' -ErrorAction SilentlyContinue

        $retentionConfigured = $false

        if ($logSettings -and $logSettings.retentionInDays -gt 0) {
            $retentionConfigured = $true
        }

        $return = $retentionConfigured

        if ($return) {
            $testResultMarkdown = "Well done. Network access logs are retained for $($logSettings.retentionInDays) days."
        } else {
            $testResultMarkdown = 'Network access logs retention is not configured. Logs should be retained for security analysis and compliance requirements.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}