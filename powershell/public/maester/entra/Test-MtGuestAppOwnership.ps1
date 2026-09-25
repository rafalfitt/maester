function Test-MtGuestAppOwnership {
    <#
    .SYNOPSIS
    Checks if guest users own applications in the tenant.

    .DESCRIPTION
    Guest users should not own applications in the tenant as this could lead to unauthorized access
    or privilege escalation. This test verifies that no guest users are owners of applications.

    .EXAMPLE
    Test-MtGuestAppOwnership

    Returns true if no guest users own applications.

    .LINK
    https://maester.dev/docs/commands/Test-MtGuestAppOwnership
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get all applications with owners
        $apps = @(Invoke-MtGraphRequest -RelativeUri 'applications?$select=id,displayName,appId,owners' -ErrorAction Stop)

        $guestOwners = @()

        foreach ($app in $apps) {
            if ($app.owners -and $app.owners.Count -gt 0) {
                foreach ($owner in $app.owners) {
                    # Check if owner is a guest user (userType == Guest)
                    if ($owner.userType -eq 'Guest') {
                        $guestOwners += [pscustomobject]@{
                            AppDisplayName         = $app.displayName
                            AppId                  = $app.appId
                            OwnerDisplayName       = $owner.displayName
                            OwnerUserPrincipalName = $owner.userPrincipalName
                        }
                    }
                }
            }
        }

        $return = $guestOwners.Count -eq 0

        if ($return) {
            $testResultMarkdown = 'Well done. No guest users own applications in the tenant.'
        } else {
            $testResultMarkdown = "You have $($guestOwners.Count) application(s) owned by guest users.`n`n%TestResult%"

            $result = "| Application | App ID | Guest Owner | Owner UPN |`n"
            $result += "| --- | --- | --- | --- |`n"
            foreach ($owner in $guestOwners) {
                $result += "| $($owner.AppDisplayName) | $($owner.AppId) | $($owner.OwnerDisplayName) | $($owner.OwnerUserPrincipalName) |`n"
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