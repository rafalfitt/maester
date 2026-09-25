function Test-MtAppInstancePropertyLock {
    <#
    .SYNOPSIS
    Checks if app instance property lock is configured for all multitenant applications.

    .DESCRIPTION
    App instance property lock prevents unauthorized changes to multitenant application properties
    by locking them to the home tenant. This test verifies that all multitenant apps have property lock enabled.

    .EXAMPLE
    Test-MtAppInstancePropertyLock

    Returns true if all multitenant applications have app instance property lock configured.

    .LINK
    https://maester.dev/docs/commands/Test-MtAppInstancePropertyLock
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get all multitenant applications (service principals with appOwnerOrganizationId not equal to current tenant)
        $multiTenantApps = @(Invoke-MtGraphRequest -RelativeUri 'servicePrincipals?$filter=appOwnerOrganizationId ne null and appOwnerOrganizationId ne \'Microsoft Corporation\'&$select=id,displayName,appId,appOwnerOrganizationId,servicePrincipalNames' -ErrorAction Stop)

        Write-Verbose "Found $($multiTenantApps.Count) multitenant service principals."

        $appsWithoutLock = @()

        foreach ($app in $multiTenantApps) {
            # Check if app instance property lock is enabled
            # This is typically configured via the service principal's tags or specific properties
            $hasLock = $false

            if ($app.tags) {
                foreach ($tag in $app.tags) {
                    if ($tag -like 'AppInstancePropertyLock*') {
                        $hasLock = $true
                        break
                    }
                }
            }

            if (-not $hasLock) {
                $appsWithoutLock += [pscustomobject]@{
                    DisplayName = $app.displayName
                    AppId       = $app.appId
                    OwnerOrg    = $app.appOwnerOrganizationId
                }
            }
        }

        $return = $appsWithoutLock.Count -eq 0

        if ($return) {
            $testResultMarkdown = 'Well done. All multitenant applications have app instance property lock configured.'
        } else {
            $testResultMarkdown = "You have $($appsWithoutLock.Count) multitenant application(s) without app instance property lock.`n`n%TestResult%"

            $result = "| Application | App ID | Owner Organization |`n"
            $result += "| --- | --- | --- |`n"
            foreach ($app in $appsWithoutLock) {
                $result += "| $($app.DisplayName) | $($app.AppId) | $($app.OwnerOrg) |`n"
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