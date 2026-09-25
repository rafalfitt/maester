function Test-MtServicePrincipalSafeRedirectUris {
    <#
    .SYNOPSIS
    Checks if service principals use safe redirect URIs.

    .DESCRIPTION
    Service principals (enterprise applications) should not use redirect URIs that are insecure.
    This test identifies service principals with unsafe redirect URIs.

    .EXAMPLE
    Test-MtServicePrincipalSafeRedirectUris

    Returns true if no service principals have unsafe redirect URIs.

    .LINK
    https://maester.dev/docs/commands/Test-MtServicePrincipalSafeRedirectUris
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get all service principals with redirect URIs
        $sps = @(Invoke-MtGraphRequest -RelativeUri 'servicePrincipals?$select=id,displayName,appId,replyUrls' -ErrorAction Stop)

        Write-Verbose "Found $($sps.Count) service principals."

        $spsWithUnsafeRedirects = @()

        foreach ($sp in $sps) {
            $unsafeRedirects = @()

            if ($sp.replyUrls) {
                foreach ($uri in $sp.replyUrls) {
                    if ($uri -like 'http://*' -and $uri -notlike 'http://localhost*' -and $uri -notlike 'http://127.0.0.1*') {
                        $unsafeRedirects += "$uri (HTTP not localhost)"
                    } elseif ($uri -like '*://*' -and ($uri -like '*//*' -and $uri -notmatch '^https?://[^/]+')) {
                        $unsafeRedirects += "$uri (wildcard/invalid)"
                    }
                }
            }

            if ($unsafeRedirects.Count -gt 0) {
                $spsWithUnsafeRedirects += [pscustomobject]@{
                    DisplayName     = $sp.displayName
                    AppId           = $sp.appId
                    UnsafeRedirects = $unsafeRedirects -join '; '
                }
            }
        }

        $return = $spsWithUnsafeRedirects.Count -eq 0

        if ($return) {
            $testResultMarkdown = 'Well done. No service principals have unsafe redirect URIs.'
        } else {
            $testResultMarkdown = "You have $($spsWithUnsafeRedirects.Count) service principal(s) with unsafe redirect URIs.`n`n%TestResult%"

            $result = "| Application | App ID | Unsafe Redirect URIs |`n"
            $result += "| --- | --- | --- |`n"
            foreach ($sp in $spsWithUnsafeRedirects) {
                $result += "| $($sp.DisplayName) | $($sp.AppId) | $($sp.UnsafeRedirects) |`n"
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