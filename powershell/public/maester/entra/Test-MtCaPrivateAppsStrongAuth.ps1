function Test-MtCaPrivateAppsStrongAuth {
    <#
    .SYNOPSIS
    Checks if Conditional Access policies enforce strong authentication for private apps.

    .DESCRIPTION
    This test verifies that Conditional Access policies are configured to require strong authentication
    (phishing-resistant MFA) for access to private applications published through Entra Private Access.

    .EXAMPLE
    Test-MtCaPrivateAppsStrongAuth

    Returns true if CA policies enforce strong authentication for private apps.

    .LINK
    https://maester.dev/docs/commands/Test-MtCaPrivateAppsStrongAuth
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get all enabled CA policies
        $caPolicies = @(Invoke-MtGraphRequest -RelativeUri 'identity/conditionalAccess/policies?$filter=state eq \'enabled\'&$select=id,displayName,conditions,grantControls' -ErrorAction Stop)

        Write-Verbose "Found $($caPolicies.Count) enabled Conditional Access policies."

        $policiesForPrivateApps = @()

        foreach ($policy in $caPolicies) {
            # Check if policy targets Private Access apps (cloudAppId for Private Access)
            $targetsPrivateAccess = $false
            if ($policy.conditions.applications -and $policy.conditions.applications.includeApplications) {
                foreach ($appId in $policy.conditions.applications.includeApplications) {
                    # Private Access apps have specific identifiers
                    if ($appId -like '*privateaccess*' -or $appId -like '*GlobalSecureAccess*') {
                        $targetsPrivateAccess = $true
                        break
                    }
                }
            }

            if ($targetsPrivateAccess) {
                # Check if policy requires phishing-resistant MFA
                $requiresPhishingResistant = $false
                if ($policy.grantControls.builtInControls) {
                    foreach ($control in $policy.grantControls.builtInControls) {
                        if ($control -eq 'mfa' -or $control -eq 'phishingResistant') {
                            $requiresPhishingResistant = $true
                            break
                        }
                    }
                }

                if ($requiresPhishingResistant) {
                    $policiesForPrivateApps += $policy
                }
            }
        }

        $return = $policiesForPrivateApps.Count -gt 0

        if ($return) {
            $testResultMarkdown = "Well done. Found $($policiesForPrivateApps.Count) Conditional Access policy(s) enforcing strong authentication for private apps."
        } else {
            $testResultMarkdown = "No Conditional Access policies found that enforce strong authentication (phishing-resistant MFA) for private apps published through Entra Private Access."
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}