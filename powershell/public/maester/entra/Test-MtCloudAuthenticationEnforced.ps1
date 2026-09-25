function Test-MtCloudAuthenticationEnforced {
    <#
    .SYNOPSIS
    Checks if cloud authentication is enforced (no federated domains for user authentication).

    .DESCRIPTION
    This test verifies that the tenant uses cloud authentication (managed domains) rather than
    federation for user authentication. Federated domains can introduce security risks if the
    on-premises identity provider is compromised.

    .EXAMPLE
    Test-MtCloudAuthenticationEnforced

    Returns true if all domains use cloud authentication.

    .LINK
    https://maester.dev/docs/commands/Test-MtCloudAuthenticationEnforced
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get all domains
        $domains = @(Invoke-MtGraphRequest -RelativeUri 'domains?$select=id,authenticationType' -ErrorAction Stop)

        Write-Verbose "Found $($domains.Count) domains."

        $federatedDomains = $domains | Where-Object { $_.authenticationType -eq 'Federated' }

        $return = $federatedDomains.Count -eq 0

        if ($return) {
            $testResultMarkdown = 'Well done. All domains use cloud authentication (managed).'
        } else {
            $testResultMarkdown = "You have $($federatedDomains.Count) federated domain(s) that use on-premises identity providers for authentication.`n`n%TestResult%"

            $result = "| Domain | Authentication Type |`n"
            $result += "| --- | --- |`n"
            foreach ($domain in $federatedDomains) {
                $result += "| $($domain.id) | $($domain.authenticationType) |`n"
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