function Test-MtEntraConnectLegacyServiceAccounts {
    <#
    .SYNOPSIS
    Checks if legacy Entra Connect user-type service accounts with high privileges are still present.

    .DESCRIPTION
    Legacy Entra Connect deployments used user-type service accounts with high privileges (like Global Admin).
    Modern deployments should use Service Principals with certificate-based authentication. This test
    identifies any remaining legacy user-type service accounts with privileged roles.

    .EXAMPLE
    Test-MtEntraConnectLegacyServiceAccounts

    Returns true if no legacy user-type service accounts with high privileges are found.

    .LINK
    https://maester.dev/docs/commands/Test-MtEntraConnectLegacyServiceAccounts
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get all users that might be Entra Connect service accounts
        # These typically have specific display names or UPNs
        $syncUsers = @(Invoke-MtGraphRequest -RelativeUri "users?$filter=startswith(displayName,'On-Premises Directory Synchronization') or startswith(userPrincipalName,'sync_') or startswith(userPrincipalName,'ADSync')&$select=id,displayName,userPrincipalName,userType,accountEnabled,createdDateTime" -ErrorAction Stop)

        Write-Verbose "Found $($syncUsers.Count) potential Entra Connect service accounts."

        $privilegedLegacyAccounts = @()

        foreach ($user in $syncUsers) {
            # Check if user has privileged directory roles
            $memberOf = Invoke-MtGraphRequest -RelativeUri "users/$($user.id)/memberOf?$filter=startswith(id,'roleTemplateId')" -ErrorAction SilentlyContinue

            $hasPrivilegedRole = $false
            $privilegedRoles = @()

            if ($memberOf -and $memberOf.value) {
                foreach ($role in $memberOf.value) {
                    # Check for high-privilege roles
                    $roleTemplateId = $role.id
                    $privilegedRoleIds = @(
                        '62e90394-69f5-4237-9190-012177145e10', # Global Administrator
                        'b0f54661-2d74-4c50-afa3-1ec803f12efe', # Privileged Role Administrator
                        'fdd7a751-b60b-444a-984c-02652fe8fa1c', # User Administrator
                        '29232cdf-9323-42fd-ade2-1d097af3e4de', # Security Administrator
                        'e8611ab8-c189-46e8-94e1-60213ab1f814', # Application Administrator
                        '9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3'  # Cloud Application Administrator
                    )

                    if ($privilegedRoleIds -contains $roleTemplateId) {
                        $hasPrivilegedRole = $true
                        $privilegedRoles += $roleTemplateId
                    }
                }
            }

            if ($hasPrivilegedRole -and $user.accountEnabled -eq $true) {
                $privilegedLegacyAccounts += [pscustomobject]@{
                    DisplayName       = $user.displayName
                    UserPrincipalName = $user.userPrincipalName
                    UserType          = $user.userType
                    PrivilegedRoles   = $privilegedRoles -join ', '
                    CreatedDateTime   = $user.createdDateTime
                }
            }
        }

        $return = $privilegedLegacyAccounts.Count -eq 0

        if ($return) {
            $testResultMarkdown = 'Well done. No legacy Entra Connect user-type service accounts with high privileges found.'
        } else {
            $testResultMarkdown = "You have $($privilegedLegacyAccounts.Count) legacy Entra Connect user-type service account(s) with high privileges. These should be migrated to Service Principal-based authentication.`n`n%TestResult%"

            $result = "| Account | UPN | Type | Privileged Roles | Created |`n"
            $result += "| --- | --- | --- | --- | --- |`n"
            foreach ($account in $privilegedLegacyAccounts) {
                $result += "| $($account.DisplayName) | $($account.UserPrincipalName) | $($account.UserType) | $($account.PrivilegedRoles) | $($account.CreatedDateTime) |`n"
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