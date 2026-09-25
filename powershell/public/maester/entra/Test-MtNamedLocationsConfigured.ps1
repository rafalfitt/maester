function Test-MtNamedLocationsConfigured {
    <#
    .SYNOPSIS
    Checks if named locations are configured in the tenant.

    .DESCRIPTION
    Named locations define trusted IP ranges or countries that can be used in Conditional Access policies.
    This test verifies that at least one named location is configured.

    .EXAMPLE
    Test-MtNamedLocationsConfigured

    Returns true if named locations are configured.

    .LINK
    https://maester.dev/docs/commands/Test-MtNamedLocationsConfigured
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get named locations
        $namedLocations = @(Invoke-MtGraphRequest -RelativeUri 'identity/conditionalAccess/namedLocations' -ErrorAction Stop)

        $return = $namedLocations.Count -gt 0

        if ($return) {
            $testResultMarkdown = "Well done. $($namedLocations.Count) named location(s) configured."
        } else {
            $testResultMarkdown = 'No named locations configured. Named locations define trusted IP ranges or countries for use in Conditional Access policies.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}