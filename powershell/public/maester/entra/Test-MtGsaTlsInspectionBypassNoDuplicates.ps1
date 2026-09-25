function Test-MtGsaTlsInspectionBypassNoDuplicates {
    <#
    .SYNOPSIS
    Checks if TLS inspection custom bypass rules don't duplicate system bypass destinations.

    .DESCRIPTION
    Custom bypass rules should not duplicate system bypass destinations. This test verifies
    that custom bypass rules are unique.

    .EXAMPLE
    Test-MtGsaTlsInspectionBypassNoDuplicates

    Returns true if no duplicate bypass rules exist.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaTlsInspectionBypassNoDuplicates
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get GSA TLS inspection configuration
        $tlsConfig = Invoke-MtGraphRequest -RelativeUri 'networkAccess/tlsInspectionProfiles' -ErrorAction SilentlyContinue

        $noDuplicates = $true
        $duplicates = @()

        if ($tlsConfig -and $tlsConfig.value) {
            foreach ($profile in $tlsConfig.value) {
                $systemDestinations = @()
                $customDestinations = @()

                if ($profile.systemBypassDestinations) {
                    $systemDestinations += $profile.systemBypassDestinations
                }

                if ($profile.customBypassRules) {
                    foreach ($rule in $profile.customBypassRules) {
                        if ($rule.destination) {
                            $customDestinations += $rule.destination
                        }
                    }
                }

                # Check for duplicates
                foreach ($custom in $customDestinations) {
                    if ($systemDestinations -contains $custom) {
                        $noDuplicates = $false
                        $duplicates += [pscustomobject]@{
                            ProfileName          = $profile.displayName
                            DuplicateDestination = $custom
                        }
                    }
                }
            }
        }

        $return = $noDuplicates

        if ($return) {
            $testResultMarkdown = 'Well done. No custom TLS inspection bypass rules duplicate system bypass destinations.'
        } else {
            $testResultMarkdown = "$($duplicates.Count) custom bypass rule(s) duplicate system bypass destinations.`n`n%TestResult%"

            $result = "| Profile | Duplicate Destination |`n"
            $result += "| --- | --- |`n"
            foreach ($dup in $duplicates) {
                $result += "| $($dup.ProfileName) | $($dup.DuplicateDestination) |`n"
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