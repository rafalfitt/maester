function Test-MtAiAdministrativeRolesHavePrincipals {
    <#
    .SYNOPSIS
    Checks if AI administrative roles have assigned principals.

    .DESCRIPTION
    AI administrative roles (like AI Administrator, AI Developer) should have assigned principals
    to ensure accountability. This test verifies that all AI admin roles have at least one assignment.

    .EXAMPLE
    Test-MtAiAdministrativeRolesHavePrincipals

    Returns true if all AI administrative roles have assigned principals.

    .LINK
    https://maester.dev/docs/commands/Test-MtAiAdministrativeRolesHavePrincipals
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get AI administrative role definitions
        $aiAdminRoles = @(
            'AI Administrator',
            'AI Developer',
            'AI Operator'
        )

        $rolesWithoutPrincipals = @()

        foreach ($roleName in $aiAdminRoles) {
            $role = @(Invoke-MtGraphRequest -RelativeUri "roleManagement/directory/roleDefinitions?$filter=displayName eq '$roleName'" -ErrorAction SilentlyContinue)

            if ($role -and $role.value) {
                $roleId = $role.value[0].id
                $assignments = @(Invoke-MtGraphRequest -RelativeUri "roleManagement/directory/roleAssignments?$filter=roleDefinitionId eq '$roleId'" -ErrorAction SilentlyContinue)

                if (-not $assignments -or $assignments.Count -eq 0) {
                    $rolesWithoutPrincipals += $roleName
                }
            }
        }

        $return = $rolesWithoutPrincipals.Count -eq 0

        if ($return) {
            $testResultMarkdown = 'Well done. All AI administrative roles have assigned principals.'
        } else {
            $testResultMarkdown = "The following AI administrative roles have no assigned principals: $($rolesWithoutPrincipals -join ', ')."
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}