function Test-MtGsaTlsInspectionFailureRate {
    <#
    .SYNOPSIS
    Checks if TLS inspection failure rate is below 1%.

    .DESCRIPTION
    High TLS inspection failure rates can indicate configuration issues. This test verifies
    that the failure rate is below 1%.

    .EXAMPLE
    Test-MtGsaTlsInspectionFailureRate

    Returns true if TLS inspection failure rate is below 1%.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaTlsInspectionFailureRate
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get GSA TLS inspection metrics
        $metrics = Invoke-MtGraphRequest -RelativeUri 'networkAccess/tlsInspectionProfiles/metrics' -ErrorAction SilentlyContinue

        $failureRateOk = $true
        $highFailureProfiles = @()

        if ($metrics -and $metrics.value) {
            foreach ($metric in $metrics.value) {
                if ($metric.failureRate -and $metric.failureRate -gt 0.01) {
                    $failureRateOk = $false
                    $highFailureProfiles += [pscustomobject]@{
                        ProfileName = $metric.profileDisplayName
                        FailureRate = ($metric.failureRate * 100).ToString('F2') + '%'
                    }
                }
            }
        }

        $return = $failureRateOk

        if ($return) {
            $testResultMarkdown = 'Well done. TLS inspection failure rate is below 1% for all profiles.'
        } else {
            $testResultMarkdown = "$($highFailureProfiles.Count) TLS inspection profile(s) have failure rate above 1%.`n`n%TestResult%"

            $result = "| Profile | Failure Rate |`n"
            $result += "| --- | --- |`n"
            foreach ($p in $highFailureProfiles) {
                $result += "| $($p.ProfileName) | $($p.FailureRate) |`n"
            }
            $testResultMarkdown = $testResultMarkdown -replace '%TestResult%', $result
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}