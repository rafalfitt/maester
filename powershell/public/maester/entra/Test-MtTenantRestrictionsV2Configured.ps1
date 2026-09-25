function Test-MtTenantRestrictionsV2Configured {
    <#
    .SYNOPSIS
    Checks if Tenant Restrictions v2 policy is configured.

    .DESCRIPTION
    Tenant Restrictions v2 controls which tenants users can access. This test verifies that
    a Tenant Restrictions v2 policy is configured.

    .EXAMPLE
    Test-MtTenantRestrictionsV2Configured

    Returns true if Tenant Restrictions v2 policy is configured.

    .LINK
    https://maester.dev/docs/commands/Test-MtTenantRestrictionsV2Configured
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get tenant restrictions configuration
        $tenantRestrictions = Invoke-MtGraphRequest -RelativeUri 'policies/tenantRestrictionPolicy' -ApiVersion 'beta' -ErrorAction SilentlyContinue

        $configured = $false

        if ($tenantRestrictions -and $tenantRestrictions.isEnabled -eq $true) {
            $configured = $true
        }

        $return = $configured

        if ($return) {
            $testResultMarkdown = 'Well done. Tenant Restrictions v2 policy is configured and enabled.'
        } else {
            $testResultMarkdown = 'Tenant Restrictions v2 policy is not configured or not enabled. This controls which tenants users can access.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}