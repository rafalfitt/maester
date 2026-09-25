function Test-MtGuestSponsors {
    <#
    .SYNOPSIS
    Checks if all guest users have a sponsor assigned.

    .DESCRIPTION
    All guest users should have a sponsor assigned for accountability and access reviews.
    This test verifies that every guest user has at least one sponsor.

    .EXAMPLE
    Test-MtGuestSponsors

    Returns true if all guest users have sponsors.

    .LINK
    https://maester.dev/docs/commands/Test-MtGuestSponsors
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get all guest users
        $guestUsers = @(Invoke-MtGraphRequest -RelativeUri 'users?$filter=userType eq \'Guest\'&$select=id,displayName,userPrincipalName,createdDateTime' -ErrorAction Stop)

        Write-Verbose "Found $($guestUsers.Count) guest users."

        $guestsWithoutSponsor = @()

        foreach ($guest in $guestUsers) {
            # Get the guest's manager/sponsor
            $manager = Invoke-MtGraphRequest -RelativeUri "users/$($guest.id)/manager" -ErrorAction SilentlyContinue

            if (-not $manager -or -not $manager.id) {
                $guestsWithoutSponsor += [pscustomobject]@{
                    DisplayName       = $guest.displayName
                    UserPrincipalName = $guest.userPrincipalName
                    CreatedDateTime   = $guest.createdDateTime
                }
            }
        }

        $return = $guestsWithoutSponsor.Count -eq 0

        if ($return) {
            $testResultMarkdown = 'Well done. All guest users have a sponsor assigned.'
        } else {
            $testResultMarkdown = "You have $($guestsWithoutSponsor.Count) guest user(s) without a sponsor assigned.`n`n%TestResult%"

            $result = "| Guest User | UPN | Created |`n"
            $result += "| --- | --- | --- |`n"
            foreach ($guest in $guestsWithoutSponsor | Select-Object -First 20) {
                $result += "| $($guest.DisplayName) | $($guest.UserPrincipalName) | $($guest.CreatedDateTime) |`n"
            }
            if ($guestsWithoutSponsor.Count -gt 20) {
                $result += "| ... and $($guestsWithoutSponsor.Count - 20) more | | |`n"
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