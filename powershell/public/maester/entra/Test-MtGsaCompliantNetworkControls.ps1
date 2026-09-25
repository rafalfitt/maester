function Test-MtGsaCompliantNetworkControls {
    <#
    .SYNOPSIS
    Checks if Conditional Access policies use compliant network controls.

    .DESCRIPTION
    CA policies should use compliant network controls (GSA compliant network) for access decisions.
    This test verifies that CA policies reference compliant network conditions.

    .EXAMPLE
    Test-MtGsaCompliantNetworkControls

    Returns true if CA policies use compliant network controls.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaCompliantNetworkControls
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get enabled CA policies
        $caPolicies = @(Invoke-MtGraphRequest -RelativeUri 'identity/conditionalAccess/policies?$filter=state eq \'enabled\'&$select=id,displayName,conditions' -ErrorAction Stop)

        $usesCompliantNetwork = $false

        foreach ($policy in $caPolicies) {
            if ($policy.conditions.networkAccess -and $policy.conditions.networkAccess.includeNetworkAccess) {
                foreach ($network in $policy.conditions.networkAccess.includeNetworkAccess) {
                    if ($network -like '*compliant*' -or $network -like '*GlobalSecureAccess*') {
                        $usesCompliantNetwork = $true
                        break
                    }
                }
            }
            if ($usesCompliantNetwork) { break }
        }

        $return = $usesCompliantNetwork

        if ($return) {
            $testResultMarkdown = 'Well done. Conditional Access policies use compliant network controls.'
        } else {
            $testResultMarkdown = 'Conditional Access policies do not use compliant network controls. CA policies should reference GSA compliant network for access decisions.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}