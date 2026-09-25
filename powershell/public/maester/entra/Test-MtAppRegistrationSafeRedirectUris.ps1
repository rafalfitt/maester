function Test-MtAppRegistrationSafeRedirectUris {
    <#
    .SYNOPSIS
    Checks if app registrations use safe redirect URIs.

    .DESCRIPTION
    App registrations should not use redirect URIs that are insecure (e.g., http://localhost, wildcard patterns).
    This test identifies app registrations with unsafe redirect URIs.

    .EXAMPLE
    Test-MtAppRegistrationSafeRedirectUris

    Returns true if no app registrations have unsafe redirect URIs.

    .LINK
    https://maester.dev/docs/commands/Test-MtAppRegistrationSafeRedirectUris
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get all app registrations with redirect URIs
        $apps = @(Invoke-MtGraphRequest -RelativeUri 'applications?$select=id,displayName,appId,web,spa,publicClient' -ErrorAction Stop)

        Write-Verbose "Found $($apps.Count) app registrations."

        $appsWithUnsafeRedirects = @()

        foreach ($app in $apps) {
            $unsafeRedirects = @()

            # Check web redirect URIs
            if ($app.web -and $app.web.redirectUris) {
                foreach ($uri in $app.web.redirectUris) {
                    if ($uri -like 'http://*' -and $uri -notlike 'http://localhost*' -and $uri -notlike 'http://127.0.0.1*') {
                        $unsafeRedirects += "Web: $uri (HTTP not localhost)"
                    } elseif ($uri -like '*://*' -and ($uri -like '*//*' -and $uri -notmatch '^https?://[^/]+')) {
                        $unsafeRedirects += "Web: $uri (wildcard/invalid)"
                    }
                }
            }

            # Check SPA redirect URIs
            if ($app.spa -and $app.spa.redirectUris) {
                foreach ($uri in $app.spa.redirectUris) {
                    if ($uri -like 'http://*' -and $uri -notlike 'http://localhost*' -and $uri -notlike 'http://127.0.0.1*') {
                        $unsafeRedirects += "SPA: $uri (HTTP not localhost)"
                    }
                }
            }

            # Check public client redirect URIs
            if ($app.publicClient -and $app.publicClient.redirectUris) {
                foreach ($uri in $app.publicClient.redirectUris) {
                    if ($uri -like 'http://*' -and $uri -notlike 'http://localhost*' -and $uri -notlike 'http://127.0.0.1*') {
                        $unsafeRedirects += "PublicClient: $uri (HTTP not localhost)"
                    }
                }
            }

            if ($unsafeRedirects.Count -gt 0) {
                $appsWithUnsafeRedirects += [pscustomobject]@{
                    DisplayName     = $app.displayName
                    AppId           = $app.appId
                    UnsafeRedirects = $unsafeRedirects -join '; '
                }
            }
        }

        $return = $appsWithUnsafeRedirects.Count -eq 0

        if ($return) {
            $testResultMarkdown = 'Well done. No app registrations have unsafe redirect URIs.'
        } else {
            $testResultMarkdown = "You have $($appsWithUnsafeRedirects.Count) app registration(s) with unsafe redirect URIs.`n`n%TestResult%"

            $result = "| Application | App ID | Unsafe Redirect URIs |`n"
            $result += "| --- | --- | --- |`n"
            foreach ($app in $appsWithUnsafeRedirects) {
                $result += "| $($app.DisplayName) | $($app.AppId) | $($app.UnsafeRedirects) |`n"
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