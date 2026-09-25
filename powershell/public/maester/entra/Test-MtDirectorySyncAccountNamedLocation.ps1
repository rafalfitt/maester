function Test-MtDirectorySyncAccountNamedLocation {
    <#
    .SYNOPSIS
    Checks if the directory sync account is locked down to a specific named location.

    .DESCRIPTION
    The directory synchronization account (Entra Connect sync account) should only be allowed to sign in
    from specific named locations (IP ranges) to prevent unauthorized access.

    .EXAMPLE
    Test-MtDirectorySyncAccountNamedLocation

    Returns true if the directory sync account is restricted to named locations.

    .LINK
    https://maester.dev/docs/commands/Test-MtDirectorySyncAccountNamedLocation
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get the directory sync service principal
        $syncSp = @(Invoke-MtGraphRequest -RelativeUri "servicePrincipals?$filter=appDisplayName eq 'On-Premises Directory Synchronization Service Account'&$select=id,displayName,appId" -ErrorAction Stop)

        if ($syncSp.Count -eq 0) {
            Add-MtTestResultDetail -SkippedBecause NotFound -SkippedError "Directory sync service principal not found"
            return $null
        }

        $syncSpId = $syncSp[0].id

        # Check Conditional Access policies targeting this service principal
        $caPolicies = @(Invoke-MtGraphRequest -RelativeUri 'identity/conditionalAccess/policies?$filter=state eq \'enabled\'&$select=id,displayName,conditions,grantControls' -ErrorAction Stop)

        $restrictedToNamedLocation = $false

        foreach ($policy in $caPolicies) {
            # Check if policy targets the sync service principal
            $targetsSyncSp = $false
            if ($policy.conditions.users -and $policy.conditions.users.includeGuestsOrExternalUsers -eq $false) {
                if ($policy.conditions.users.includeUsers) {
                    foreach ($userId in $policy.conditions.users.includeUsers) {
                        if ($userId -eq $syncSpId) {
                            $targetsSyncSp = $true
                            break
                        }
                    }
                }
            }

            if ($targetsSyncSp) {
                # Check if policy requires named location
                if ($policy.conditions.locations -and $policy.conditions.locations.includeLocations) {
                    foreach ($locId in $policy.conditions.locations.includeLocations) {
                        if ($locId -ne 'AllTrusted') {
                            $restrictedToNamedLocation = $true
                            break
                        }
                    }
                }
            }

            if ($restrictedToNamedLocation) { break }
        }

        $return = $restrictedToNamedLocation

        if ($return) {
            $testResultMarkdown = 'Well done. The directory sync account is restricted to specific named locations via Conditional Access.'
        } else {
            $testResultMarkdown = 'The directory sync account is **not** restricted to specific named locations. It should only be allowed to sign in from known IP ranges.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}