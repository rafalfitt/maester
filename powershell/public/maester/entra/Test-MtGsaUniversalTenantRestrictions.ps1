function Test-MtGsaUniversalTenantRestrictions {
    <#
    .SYNOPSIS
    Checks if universal tenant restrictions block unauthorized external tenant access.

    .DESCRIPTION
    Universal tenant restrictions should block access to unauthorized external tenants.
    This test verifies that universal tenant restrictions are configured.

    .EXAMPLE
    Test-MtGsaUniversalTenantRestrictions

    Returns true if universal tenant restrictions are configured.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaUniversalTenantRestrictions
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get universal tenant restrictions configuration
        $restrictions = Invoke-MtGraphRequest -RelativeUri 'policies/universalTenantRestrictionPolicy' -ErrorAction SilentlyContinue

        $configured = $false

        if ($restrictions -and $restrictions.isEnabled -eq $true) {
            $configured = $true
        }

        $return = $configured

        if ($return) {
            $testResultMarkdown = 'Well done. Universal tenant restrictions are configured to block unauthorized external tenant access.'
        } else {
            $testResultMarkdown = 'Universal tenant restrictions are not configured. They should block unauthorized external tenant access.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}