function Test-MtGlobalAdminActivationApproval {
    <#
    .SYNOPSIS
    Checks if Global Administrator role activation triggers an approval workflow.

    .DESCRIPTION
    Global Administrator role activations should require approval through PIM. This test
    verifies that the Global Admin role has an approval workflow configured.

    .EXAMPLE
    Test-MtGlobalAdminActivationApproval

    Returns true if Global Admin role activation requires approval.

    .LINK
    https://maester.dev/docs/commands/Test-MtGlobalAdminActivationApproval
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Check if tenant has P2 license
        $license = Get-MtLicenseInformation -Product EntraID
        if ($license -ne 'P2') {
            Add-MtTestResultDetail -SkippedBecause NotLicensedEntraIDP2
            return $null
        }

        # Check role eligibility settings for Global Administrator
        $roleEligibility = Invoke-MtGraphRequest -RelativeUri "roleManagement/directory/roleEligibilitySchedules?$filter=roleDefinitionId eq '62e90394-69f5-4237-9190-012177145e10'" -ErrorAction Stop

        $requiresApproval = $false

        if ($roleEligibility -and $roleEligibility.value) {
            foreach ($schedule in $roleEligibility.value) {
                if ($schedule.requiresApproval -eq $true) {
                    $requiresApproval = $true
                    break
                }
            }
        }

        $return = $requiresApproval

        if ($return) {
            $testResultMarkdown = 'Well done. Global Administrator role activation requires approval.'
        } else {
            $testResultMarkdown = 'Global Administrator role activation does not require approval. It should be configured to require approval through PIM.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}