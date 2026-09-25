function Test-MtGsaTlsInspectionBypassReviewed {
    <#
    .SYNOPSIS
    Checks if TLS inspection bypass rules are regularly reviewed.

    .DESCRIPTION
    TLS inspection bypass rules should be regularly reviewed to ensure they are still necessary.
    This test checks if bypass rules have been reviewed recently.

    .EXAMPLE
    Test-MtGsaTlsInspectionBypassReviewed -MaxDaysSinceReview 90

    Returns true if TLS inspection bypass rules have been reviewed within the specified period.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaTlsInspectionBypassReviewed
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param(
        [int] $MaxDaysSinceReview = 90
    )

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get GSA TLS inspection configuration
        $tlsConfig = Invoke-MtGraphRequest -RelativeUri 'networkAccess/tlsInspectionProfiles' -ErrorAction SilentlyContinue

        $reviewed = $false

        if ($tlsConfig -and $tlsConfig.value) {
            foreach ($profile in $tlsConfig.value) {
                if ($profile.bypassRules) {
                    foreach ($rule in $profile.bypassRules) {
                        if ($rule.lastReviewedDateTime) {
                            $lastReviewed = [datetime]$rule.lastReviewedDateTime
                            if ($lastReviewed -gt (Get-Date).AddDays(-$MaxDaysSinceReview)) {
                                $reviewed = $true
                            }
                        }
                    }
                }
            }
        }

        $return = $reviewed

        if ($return) {
            $testResultMarkdown = "Well done. TLS inspection bypass rules have been reviewed within the last $MaxDaysSinceReview days."
        } else {
            $testResultMarkdown = "TLS inspection bypass rules have not been reviewed in the last $MaxDaysSinceReview days. Bypass rules should be regularly reviewed."
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}