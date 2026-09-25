function Test-MtResourceSpecificConsentRestricted {
    <#
    .SYNOPSIS
    Checks if resource-specific consent (RSC) is restricted.

    .DESCRIPTION
    Resource-specific consent allows applications to request consent for specific resources.
    This should be restricted to prevent unauthorized access. This test verifies RSC is restricted.

    .EXAMPLE
    Test-MtResourceSpecificConsentRestricted

    Returns true if resource-specific consent is restricted.

    .LINK
    https://maester.dev/docs/commands/Test-MtResourceSpecificConsentRestricted
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get authorization policy for RSC settings
        $authPolicy = Invoke-MtGraphRequest -RelativeUri 'policies/authorizationPolicy?$select=permissionGrantPoliciesAssignedToDefaultUserRole' -ApiVersion 'beta' -ErrorAction Stop

        $rscRestricted = $true

        if ($authPolicy -and $authPolicy.permissionGrantPoliciesAssignedToDefaultUserRole) {
            foreach ($policyId in $authPolicy.permissionGrantPoliciesAssignedToDefaultUserRole) {
                if ($policyId -like '*resourceSpecific*') {
                    $rscRestricted = $false
                    break
                }
            }
        }

        $return = $rscRestricted

        if ($return) {
            $testResultMarkdown = 'Well done. Resource-specific consent is restricted for default user role.'
        } else {
            $testResultMarkdown = 'Resource-specific consent is not restricted for default user role. It should be restricted to prevent unauthorized access.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}