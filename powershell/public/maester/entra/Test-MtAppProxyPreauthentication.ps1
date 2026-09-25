function Test-MtAppProxyPreauthentication {
    <#
    .SYNOPSIS
    Checks if Application Proxy applications require preauthentication to block anonymous access.

    .DESCRIPTION
    This test verifies that all Application Proxy applications are configured to require preauthentication
    (Entra ID authentication) before granting access, preventing anonymous access to on-premises applications.

    .EXAMPLE
    Test-MtAppProxyPreauthentication

    Returns true if all Application Proxy apps require preauthentication.

    .LINK
    https://maester.dev/docs/commands/Test-MtAppProxyPreauthentication
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get all Application Proxy applications (onPremisesPublishing exists)
        $appProxyApps = @(Invoke-MtGraphRequest -RelativeUri 'applications?$filter=onPremisesPublishing ne null&$select=id,displayName,appId,onPremisesPublishing' -ErrorAction Stop)

        Write-Verbose "Found $($appProxyApps.Count) Application Proxy applications."

        $appsWithoutPreauth = @()

        foreach ($app in $appProxyApps) {
            $pub = $app.onPremisesPublishing
            # Check if preauthentication is required (should be 'aadPreAuthentication' or similar)
            $preAuth = $pub.preAuthentication
            if ($preAuth -ne 'aadPreAuthentication' -and $preAuth -ne 'passthru') {
                # If preAuthentication is null or 'none', it allows anonymous access
                $appsWithoutPreauth += [pscustomobject]@{
                    DisplayName = $app.displayName
                    AppId       = $app.appId
                    PreAuth     = if ($preAuth) { $preAuth } else { 'Not configured (allows anonymous)' }
                }
            }
        }

        $return = $appsWithoutPreauth.Count -eq 0

        if ($return) {
            $testResultMarkdown = 'Well done. All Application Proxy applications require preauthentication.'
        } else {
            $testResultMarkdown = "You have $($appsWithoutPreauth.Count) Application Proxy application(s) that do not require preauthentication (allow anonymous access).`n`n%TestResult%"

            $result = "| Application | App ID | Preauthentication Setting |`n"
            $result += "| --- | --- | --- |`n"
            foreach ($app in $appsWithoutPreauth) {
                $result += "| $($app.DisplayName) | $($app.AppId) | $($app.PreAuth) |`n"
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