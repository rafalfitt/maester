function Test-MtWorkloadIdentitiesRiskBasedPolicies {
    <#
    .SYNOPSIS
    Checks if workload identities are configured with risk-based policies.

    .DESCRIPTION
    Workload identities should have risk-based Conditional Access policies configured
    to automatically respond to risk events. This test verifies that such policies exist.

    .EXAMPLE
    Test-MtWorkloadIdentitiesRiskBasedPolicies

    Returns true if workload identities have risk-based policies configured.

    .LINK
    https://maester.dev/docs/commands/Test-MtWorkloadIdentitiesRiskBasedPolicies
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get CA policies that target workload identities with risk conditions
        $caPolicies = @(Invoke-MtGraphRequest -RelativeUri 'identity/conditionalAccess/policies?$filter=state eq \'enabled\'&$select=id,displayName,conditions,grantControls' -ErrorAction Stop)

        $hasRiskBasedPolicy = $false

        foreach ($policy in $caPolicies) {
            # Check if policy targets service principals/workload identities
            $targetsWorkloadIdentities = $false
            if ($policy.conditions.servicePrincipals -and $policy.conditions.servicePrincipals.includeServicePrincipals) {
                $targetsWorkloadIdentities = $true
            }

            # Check if policy uses risk-based conditions
            $usesRiskCondition = $false
            if ($policy.conditions.signInRiskLevels -or $policy.conditions.userRiskLevels) {
                $usesRiskCondition = $true
            }

            if ($targetsWorkloadIdentities -and $usesRiskCondition) {
                $hasRiskBasedPolicy = $true
                break
            }
        }

        $return = $hasRiskBasedPolicy

        if ($return) {
            $testResultMarkdown = 'Well done. Workload identities have risk-based Conditional Access policies configured.'
        } else {
            $testResultMarkdown = 'Workload identities do not have risk-based Conditional Access policies configured. Risk-based policies should be configured to automatically respond to risk events.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}