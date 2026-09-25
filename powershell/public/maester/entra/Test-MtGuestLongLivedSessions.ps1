function Test-MtGuestLongLivedSessions {
    <#
    .SYNOPSIS
    Checks if guest users have long-lived sign-in sessions configured.

    .DESCRIPTION
    Guest users should not have long-lived sign-in sessions. This test verifies that the
    sign-in frequency for guest users is configured appropriately.

    .EXAMPLE
    Test-MtGuestLongLivedSessions

    Returns true if guest users do not have long-lived sessions.

    .LINK
    https://maester.dev/docs/commands/Test-MtGuestLongLivedSessions
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get Conditional Access policies that target guest users
        $caPolicies = @(Invoke-MtGraphRequest -RelativeUri 'identity/conditionalAccess/policies?$filter=state eq \'enabled\'&$select=id,displayName,conditions,sessionControls' -ErrorAction Stop)

        $guestSessionConfigured = $false

        foreach ($policy in $caPolicies) {
            # Check if policy targets guest users
            $targetsGuests = $false
            if ($policy.conditions.users -and $policy.conditions.users.includeGuestsOrExternalUsers -eq $true) {
                $targetsGuests = $true
            } elseif ($policy.conditions.users -and $policy.conditions.users.includeUsers) {
                foreach ($userId in $policy.conditions.users.includeUsers) {
                    # Check if it's a guest user (this is simplified)
                    if ($userId -like '*#EXT#*') {
                        $targetsGuests = $true
                        break
                    }
                }
            }

            if ($targetsGuests -and $policy.sessionControls) {
                # Check for sign-in frequency
                if ($policy.sessionControls.signInFrequency -and $policy.sessionControls.signInFrequency.value -le 24) {
                    $guestSessionConfigured = $true
                    break
                }
                # Check for persistent browser session
                if ($policy.sessionControls.persistentBrowser -and $policy.sessionControls.persistentBrowser.mode -eq 'never') {
                    $guestSessionConfigured = $true
                    break
                }
            }
        }

        $return = $guestSessionConfigured

        if ($return) {
            $testResultMarkdown = 'Well done. Guest users have sign-in frequency or persistent browser session controls configured.'
        } else {
            $testResultMarkdown = 'Guest users do not have sign-in frequency or persistent browser session controls configured. Guest sessions should be limited.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}