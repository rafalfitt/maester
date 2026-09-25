function Test-MtBlockAdminsFromSspr {
    <#
    .SYNOPSIS
    Checks if administrators are blocked from using Self-Service Password Reset (SSPR).

    .DESCRIPTION
    Administrators should not be allowed to use SSPR to reset their own passwords, as this could
    be exploited by attackers who compromise an admin account. This test verifies that the
    SSPR policy excludes administrator roles.

    .EXAMPLE
    Test-MtBlockAdminsFromSspr

    Returns true if administrators are blocked from using SSPR.

    .LINK
    https://maester.dev/docs/commands/Test-MtBlockAdminsFromSspr
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get SSPR policy
        $ssprPolicy = Invoke-MtGraphRequest -RelativeUri 'policies/selfServicePasswordResetPolicy' -ApiVersion 'beta' -ErrorAction Stop

        $adminsBlocked = $false

        if ($ssprPolicy -and $ssprPolicy.authorizationPolicy) {
            # Check if administrators are excluded from SSPR
            $adminsBlocked = $ssprPolicy.authorizationPolicy.administratorsBlockedFromSspr -eq $true
        }

        $return = $adminsBlocked

        if ($return) {
            $testResultMarkdown = 'Well done. Administrators are blocked from using Self-Service Password Reset (SSPR).'
        } else {
            $testResultMarkdown = 'Administrators are **not** blocked from using Self-Service Password Reset (SSPR). This could allow attackers who compromise an admin account to reset the password and maintain access.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}