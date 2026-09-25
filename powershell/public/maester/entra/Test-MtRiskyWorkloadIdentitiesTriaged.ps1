function Test-MtRiskyWorkloadIdentitiesTriaged {
    <#
    .SYNOPSIS
    Checks if all risky workload identities are triaged.

    .DESCRIPTION
    Workload identities (service principals, managed identities) that are flagged as risky
    should be investigated and triaged. This test verifies that no risky workload identities
    remain untriaged.

    .EXAMPLE
    Test-MtRiskyWorkloadIdentitiesTriaged

    Returns true if all risky workload identities have been triaged.

    .LINK
    https://maester.dev/docs/commands/Test-MtRiskyWorkloadIdentitiesTriaged
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get risky workload identities from Identity Protection
        $riskyWorkloadIdentities = @(Invoke-MtGraphRequest -RelativeUri 'identityProtection/riskyServicePrincipals' -ErrorAction SilentlyContinue)

        $untriagedCount = 0
        $riskyIdentities = @()

        if ($riskyWorkloadIdentities -and $riskyWorkloadIdentities.value) {
            foreach ($identity in $riskyWorkloadIdentities.value) {
                if ($identity.riskState -eq 'atRisk' -or $identity.riskState -eq 'confirmedCompromised') {
                    $untriagedCount++
                    $riskyIdentities += [pscustomobject]@{
                        DisplayName = $identity.displayName
                        AppId       = $identity.appId
                        RiskState   = $identity.riskState
                        RiskLevel   = $identity.riskLevel
                        RiskDetail  = $identity.riskDetail
                    }
                }
            }
        }

        $return = $untriagedCount -eq 0

        if ($return) {
            $testResultMarkdown = 'Well done. All risky workload identities have been triaged.'
        } else {
            $testResultMarkdown = "You have $untriagedCount risky workload identity(ies) that have not been triaged.`n`n%TestResult%"

            $result = "| Workload Identity | App ID | Risk State | Risk Level | Risk Detail |`n"
            $result += "| --- | --- | --- | --- | --- |`n"
            foreach ($identity in $riskyIdentities) {
                $result += "| $($identity.DisplayName) | $($identity.AppId) | $($identity.RiskState) | $($identity.RiskLevel) | $($identity.RiskDetail) |`n"
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