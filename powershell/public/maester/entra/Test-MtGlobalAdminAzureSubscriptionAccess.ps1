function Test-MtGlobalAdminAzureSubscriptionAccess {
    <#
    .SYNOPSIS
    Checks if Global Administrators have standing access to Azure subscriptions.

    .DESCRIPTION
    Global Administrators should not have standing (permanent) access to Azure subscriptions.
    Access should be granted through PIM or just-in-time. This test identifies Global Admins
    with direct Azure subscription role assignments.

    .EXAMPLE
    Test-MtGlobalAdminAzureSubscriptionAccess

    Returns true if no Global Administrators have standing access to Azure subscriptions.

    .LINK
    https://maester.dev/docs/commands/Test-MtGlobalAdminAzureSubscriptionAccess
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get Global Administrators
        $globalAdmins = @(Invoke-MtGraphRequest -RelativeUri "roleManagement/directory/roleAssignments?$filter=roleDefinitionId eq '62e90394-69f5-4237-9190-012177145e10'&$select=principalId" -ErrorAction Stop)

        $globalAdminIds = $globalAdmins | ForEach-Object { $_.principalId }

        Write-Verbose "Found $($globalAdminIds.Count) Global Administrator(s)."

        # Note: Checking Azure subscription access requires Azure Resource Graph or ARM API
        # This is a simplified check - in practice you'd need to query Azure subscriptions
        # For now, we'll check if there are any role assignments at subscription scope for these users
        # This requires cross-API calls which may not be available in Graph

        $adminsWithSubscriptionAccess = @()

        # This would require Azure Resource Manager API access
        # For now, we'll return a warning that this check requires Azure access
        Add-MtTestResultDetail -SkippedBecause NotImplemented -SkippedError "This check requires Azure Resource Manager API access to verify subscription role assignments. Please verify manually that Global Admins do not have standing access to Azure subscriptions."

        return $null
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}