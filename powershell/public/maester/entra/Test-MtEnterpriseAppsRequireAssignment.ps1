function Test-MtEnterpriseAppsRequireAssignment {
    <#
    .SYNOPSIS
    Checks if enterprise applications require explicit assignment or scoped provisioning.

    .DESCRIPTION
    Enterprise applications should require explicit user assignment or scoped provisioning
    to prevent unauthorized access. This test verifies that apps have assignment required.

    .EXAMPLE
    Test-MtEnterpriseAppsRequireAssignment

    Returns true if all enterprise applications require assignment.

    .LINK
    https://maester.dev/docs/commands/Test-MtEnterpriseAppsRequireAssignment
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get all enterprise applications (service principals)
        $apps = @(Invoke-MtGraphRequest -RelativeUri 'servicePrincipals?$select=id,displayName,appId,appRoleAssignmentRequired' -ErrorAction Stop)

        Write-Verbose "Found $($apps.Count) enterprise applications."

        $appsWithoutAssignment = @()

        foreach ($app in $apps) {
            # Skip Microsoft first-party apps
            if ($app.appId -like '0000000*-*' -or $app.displayName -like 'Microsoft *') { continue }

            if ($app.appRoleAssignmentRequired -ne $true) {
                $appsWithoutAssignment += [pscustomobject]@{
                    DisplayName = $app.displayName
                    AppId       = $app.appId
                }
            }
        }

        $return = $appsWithoutAssignment.Count -eq 0

        if ($return) {
            $testResultMarkdown = 'Well done. All enterprise applications require explicit assignment.'
        } else {
            $testResultMarkdown = "You have $($appsWithoutAssignment.Count) enterprise application(s) that do not require explicit assignment.`n`n%TestResult%"

            $result = "| Application | App ID |`n"
            $result += "| --- | --- |`n"
            foreach ($app in $appsWithoutAssignment | Select-Object -First 20) {
                $result += "| $($app.DisplayName) | $($app.AppId) |`n"
            }
            if ($appsWithoutAssignment.Count -gt 20) {
                $result += "| ... and $($appsWithoutAssignment.Count - 20) more | |`n"
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