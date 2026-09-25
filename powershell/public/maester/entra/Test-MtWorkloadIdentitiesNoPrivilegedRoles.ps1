function Test-MtWorkloadIdentitiesNoPrivilegedRoles {
    <#
    .SYNOPSIS
    Checks if workload identities are assigned privileged roles.

    .DESCRIPTION
    Workload identities (service principals, managed identities) should not be assigned
    privileged directory roles. This test identifies workload identities with privileged roles.

    .EXAMPLE
    Test-MtWorkloadIdentitiesNoPrivilegedRoles

    Returns true if no workload identities have privileged roles.

    .LINK
    https://maester.dev/docs/commands/Test-MtWorkloadIdentitiesNoPrivilegedRoles
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get all service principals and managed identities
        $workloadIdentities = @(Invoke-MtGraphRequest -RelativeUri 'servicePrincipals?$filter=servicePrincipalType eq \'ManagedIdentity\' or servicePrincipalType eq \'Application\'&$select=id,displayName,appId,servicePrincipalType' -ErrorAction Stop)

        Write-Verbose "Found $($workloadIdentities.Count) workload identities."

        $privilegedRoleIds = @(
            '62e90394-69f5-4237-9190-012177145e10', # Global Administrator
            'b0f54661-2d74-4c50-afa3-1ec803f12efe', # Privileged Role Administrator
            'fdd7a751-b60b-444a-984c-02652fe8fa1c', # User Administrator
            '29232cdf-9323-42fd-ade2-1d097af3e4de', # Security Administrator
            'e8611ab8-c189-46e8-94e1-60213ab1f814', # Application Administrator
            '9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3'  # Cloud Application Administrator
        )

        $workloadIdentitiesWithPrivilegedRoles = @()

        foreach ($wi in $workloadIdentities) {
            $memberOf = Invoke-MtGraphRequest -RelativeUri "servicePrincipals/$($wi.id)/memberOf?$filter=startswith(id,'roleTemplateId')" -ErrorAction SilentlyContinue

            if ($memberOf -and $memberOf.value) {
                foreach ($role in $memberOf.value) {
                    if ($privilegedRoleIds -contains $role.id) {
                        $workloadIdentitiesWithPrivilegedRoles += [pscustomobject]@{
                            DisplayName = $wi.displayName
                            AppId       = $wi.appId
                            Type        = $wi.servicePrincipalType
                            RoleId      = $role.id
                        }
                        break
                    }
                }
            }
        }

        $return = $workloadIdentitiesWithPrivilegedRoles.Count -eq 0

        if ($return) {
            $testResultMarkdown = 'Well done. No workload identities have privileged directory roles.'
        } else {
            $testResultMarkdown = "You have $($workloadIdentitiesWithPrivilegedRoles.Count) workload identity(ies) with privileged directory roles.`n`n%TestResult%"

            $result = "| Workload Identity | App ID | Type | Role ID |`n"
            $result += "| --- | --- | --- | --- |`n"
            foreach ($wi in $workloadIdentitiesWithPrivilegedRoles) {
                $result += "| $($wi.DisplayName) | $($wi.AppId) | $($wi.Type) | $($wi.RoleId) |`n"
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