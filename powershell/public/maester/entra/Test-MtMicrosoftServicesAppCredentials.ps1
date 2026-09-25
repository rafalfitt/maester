function Test-MtMicrosoftServicesAppCredentials {
    <#
    .SYNOPSIS
    Checks if Microsoft first-party service principals have credentials configured.

    .DESCRIPTION
    Microsoft first-party applications (Microsoft services) should not have client secrets or certificates
    configured as they are managed by Microsoft. This test verifies that no Microsoft-owned service
    principals have credentials that could be compromised.

    .EXAMPLE
    Test-MtMicrosoftServicesAppCredentials

    Returns true if no Microsoft first-party service principals have credentials configured.

    .LINK
    https://maester.dev/docs/commands/Test-MtMicrosoftServicesAppCredentials
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get Microsoft first-party service principals (appOwnerOrganizationId = f8cdef31-a31e-4b4a-93e4-5f571e91255a)
        $msApps = @(Invoke-MtGraphRequest -RelativeUri 'servicePrincipals?$filter=appOwnerOrganizationId eq \'f8cdef31-a31e-4b4a-93e4-5f571e91255a\'&$select=id,displayName,appId,passwordCredentials,keyCredentials' -ErrorAction Stop)

        Write-Verbose "Found $($msApps.Count) Microsoft first-party service principals."

        $appsWithCredentials = @()

        foreach ($app in $msApps) {
            $hasSecrets = $app.passwordCredentials.Count -gt 0
            $hasCerts = $app.keyCredentials.Count -gt 0

            if ($hasSecrets -or $hasCerts) {
                $credTypes = @()
                if ($hasSecrets) { $credTypes += 'Client Secrets' }
                if ($hasCerts) { $credTypes += 'Certificates' }

                $appsWithCredentials += [pscustomobject]@{
                    DisplayName     = $app.displayName
                    AppId           = $app.appId
                    CredentialTypes = $credTypes -join ', '
                }
            }
        }

        $return = $appsWithCredentials.Count -eq 0

        if ($return) {
            $testResultMarkdown = 'Well done. No Microsoft first-party service principals have credentials configured.'
        } else {
            $testResultMarkdown = "You have $($appsWithCredentials.Count) Microsoft first-party service principal(s) with credentials configured.`n`n%TestResult%"

            $result = "| Application | App ID | Credential Types |`n"
            $result += "| --- | --- | --- |`n"
            foreach ($app in $appsWithCredentials) {
                $result += "| $($app.DisplayName) | $($app.AppId) | $($app.CredentialTypes) |`n"
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