function Test-MtAppRegistrationNoDanglingRedirectUris {
    <#
    .SYNOPSIS
    Checks if app registrations have dangling or abandoned domain redirect URIs.

    .DESCRIPTION
    App registrations should not have redirect URIs pointing to domains that no longer exist
    or are not controlled by the organization. This test identifies redirect URIs with
    potentially dangling domains.

    .EXAMPLE
    Test-MtAppRegistrationNoDanglingRedirectUris

    Returns true if no app registrations have dangling domain redirect URIs.

    .LINK
    https://maester.dev/docs/commands/Test-MtAppRegistrationNoDanglingRedirectUris
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

        $appsWithDanglingRedirects = @()

        foreach ($app in $apps) {
            $allRedirects = @()

            if ($app.web -and $app.web.redirectUris) { $allRedirects += $app.web.redirectUris }
            if ($app.spa -and $app.spa.redirectUris) { $allRedirects += $app.spa.redirectUris }
            if ($app.publicClient -and $app.publicClient.redirectUris) { $allRedirects += $app.publicClient.redirectUris }

            foreach ($uri in $allRedirects) {
                # Extract domain from URI
                if ($uri -match '^https?://([^/]+)') {
                    $domain = $matches[1]
                    # Skip localhost and IP addresses
                    if ($domain -notlike 'localhost*' -and $domain -notlike '127.0.0.1*' -and $domain -notmatch '^\d+\.\d+\.\d+\.\d+$') {
                        # Try to resolve the domain
                        try {
                            $dns = [System.Net.Dns]::GetHostEntry($domain)
                            # Domain resolves - check if it's an organizational domain
                            # This is a simplified check - in practice you'd verify domain ownership
                        } catch {
                            # Domain doesn't resolve - potentially dangling
                            $appsWithDanglingRedirects += [pscustomobject]@{
                                DisplayName = $app.displayName
                                AppId       = $app.appId
                                RedirectUri = $uri
                                Domain      = $domain
                                Issue       = 'Domain does not resolve'
                            }
                        }
                    }
                }
            }
        }

        $return = $appsWithDanglingRedirects.Count -eq 0

        if ($return) {
            $testResultMarkdown = 'Well done. No app registrations have dangling domain redirect URIs.'
        } else {
            $testResultMarkdown = "You have $($appsWithDanglingRedirects.Count) redirect URI(s) with potentially dangling domains.`n`n%TestResult%"

            $result = "| Application | App ID | Redirect URI | Domain | Issue |`n"
            $result += "| --- | --- | --- | --- | --- |`n"
            foreach ($item in $appsWithDanglingRedirects | Select-Object -First 20) {
                $result += "| $($item.DisplayName) | $($item.AppId) | $($item.RedirectUri) | $($item.Domain) | $($item.Issue) |`n"
            }
            if ($appsWithDanglingRedirects.Count -gt 20) {
                $result += "| ... and $($appsWithDanglingRedirects.Count - 20) more | | | | |`n"
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