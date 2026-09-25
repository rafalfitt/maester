function Test-MtInactiveGuestCleanup {
    <#
    .SYNOPSIS
    Checks if inactive guest identities are disabled or removed from the tenant.

    .DESCRIPTION
    Inactive guest users should be disabled or removed to reduce the attack surface. This test
    identifies guest users who haven't signed in for a specified period.

    .EXAMPLE
    Test-MtInactiveGuestCleanup -InactiveDays 90

    Returns true if no inactive guest users are found.

    .LINK
    https://maester.dev/docs/commands/Test-MtInactiveGuestCleanup
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param(
        [int] $InactiveDays = 90
    )

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        $cutoffDate = (Get-Date).AddDays(-$InactiveDays).ToString('yyyy-MM-ddTHH:mm:ssZ')

        # Get all guest users
        $guestUsers = @(Invoke-MtGraphRequest -RelativeUri "users?$filter=userType eq 'Guest'&$select=id,displayName,userPrincipalName,signInActivity,accountEnabled,createdDateTime" -ErrorAction Stop)

        Write-Verbose "Found $($guestUsers.Count) guest users."

        $inactiveGuests = @()

        foreach ($guest in $guestUsers) {
            $isInactive = $false

            if ($guest.signInActivity -and $guest.signInActivity.lastSignInDateTime) {
                $lastSignIn = [datetime]$guest.signInActivity.lastSignInDateTime
                if ($lastSignIn -lt (Get-Date).AddDays(-$InactiveDays)) {
                    $isInactive = $true
                }
            } elseif ($guest.createdDateTime -and ([datetime]$guest.createdDateTime) -lt (Get-Date).AddDays(-$InactiveDays)) {
                # Never signed in and created more than InactiveDays ago
                $isInactive = $true
            }

            if ($isInactive -and $guest.accountEnabled -eq $true) {
                $inactiveGuests += [pscustomobject]@{
                    DisplayName       = $guest.displayName
                    UserPrincipalName = $guest.userPrincipalName
                    LastSignIn        = if ($guest.signInActivity.lastSignInDateTime) { $guest.signInActivity.lastSignInDateTime } else { 'Never' }
                    CreatedDateTime   = $guest.createdDateTime
                }
            }
        }

        $return = $inactiveGuests.Count -eq 0

        if ($return) {
            $testResultMarkdown = "Well done. No enabled guest users inactive for more than $InactiveDays days."
        } else {
            $testResultMarkdown = "You have $($inactiveGuests.Count) enabled guest user(s) inactive for more than $InactiveDays days.`n`n%TestResult%"

            $result = "| Guest User | UPN | Last Sign-In | Created |`n"
            $result += "| --- | --- | --- | --- |`n"
            foreach ($guest in $inactiveGuests | Select-Object -First 20) {
                $result += "| $($guest.DisplayName) | $($guest.UserPrincipalName) | $($guest.LastSignIn) | $($guest.CreatedDateTime) |`n"
            }
            if ($inactiveGuests.Count -gt 20) {
                $result += "| ... and $($inactiveGuests.Count - 20) more | | | |`n"
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