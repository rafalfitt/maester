function Test-MtAdalUsageDetected {
    <#
    .SYNOPSIS
    Checks if ADAL (Azure AD Authentication Library) is being used in the tenant.

    .DESCRIPTION
    ADAL has been deprecated and replaced by MSAL (Microsoft Authentication Library). This test
    checks sign-in logs for applications using ADAL.

    .EXAMPLE
    Test-MtAdalUsageDetected

    Returns true if no ADAL usage is detected in the last 30 days.

    .LINK
    https://maester.dev/docs/commands/Test-MtAdalUsageDetected
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param(
        [int] $DaysBack = 30
    )

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        $startDate = (Get-Date).AddDays(-$DaysBack).ToString('yyyy-MM-ddTHH:mm:ssZ')

        # Query sign-in logs for ADAL client apps
        $adalSignIns = @(Invoke-MtGraphRequest -RelativeUri "auditLogs/signIns?$filter=createdDateTime ge $startDate and clientAppUsed eq 'ADAL'&$select=id,userDisplayName,clientAppUsed,appDisplayName,createdDateTime" -ErrorAction Stop)

        $return = $adalSignIns.Count -eq 0

        if ($return) {
            $testResultMarkdown = "Well done. No ADAL usage detected in the last $DaysBack days."
        } else {
            $testResultMarkdown = "ADAL usage detected in the last $DaysBack days. $($adalSignIns.Count) sign-in(s) used ADAL.`n`n%TestResult%"

            $result = "| User | Application | Date |`n"
            $result += "| --- | --- | --- |`n"
            foreach ($signIn in $adalSignIns | Select-Object -First 20) {
                $result += "| $($signIn.userDisplayName) | $($signIn.appDisplayName) | $($signIn.createdDateTime) |`n"
            }
            if ($adalSignIns.Count -gt 20) {
                $result += "| ... and $($adalSignIns.Count - 20) more | | |`n"
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