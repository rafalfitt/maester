function Test-MtGsaTlsInspectionCertValidity {
    <#
    .SYNOPSIS
    Checks if TLS inspection certificates have a sufficient validity period.

    .DESCRIPTION
    TLS inspection certificates should have sufficient validity period to avoid service disruption.
    This test verifies that certificates are not expiring soon.

    .EXAMPLE
    Test-MtGsaTlsInspectionCertValidity -MinDaysValid 30

    Returns true if TLS inspection certificates have sufficient validity.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaTlsInspectionCertValidity
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param(
        [int] $MinDaysValid = 30
    )

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get GSA TLS inspection configuration
        $tlsConfig = Invoke-MtGraphRequest -RelativeUri 'networkAccess/tlsInspectionProfiles' -ErrorAction SilentlyContinue

        $certsValid = $true
        $expiringCerts = @()

        if ($tlsConfig -and $tlsConfig.value) {
            foreach ($profile in $tlsConfig.value) {
                if ($profile.certificate) {
                    $expiryDate = [datetime]$profile.certificate.expiryDateTime
                    $daysUntilExpiry = ($expiryDate - (Get-Date)).TotalDays

                    if ($daysUntilExpiry -lt $MinDaysValid) {
                        $certsValid = $false
                        $expiringCerts += [pscustomobject]@{
                            ProfileName   = $profile.displayName
                            ExpiryDate    = $expiryDate
                            DaysRemaining = [math]::Round($daysUntilExpiry)
                        }
                    }
                }
            }
        }

        $return = $certsValid

        if ($return) {
            $testResultMarkdown = "Well done. All TLS inspection certificates have more than $MinDaysValid days validity remaining."
        } else {
            $testResultMarkdown = "$($expiringCerts.Count) TLS inspection certificate(s) expiring within $MinDaysValid days.`n`n%TestResult%"

            $result = "| Profile | Expiry Date | Days Remaining |`n"
            $result += "| --- | --- | --- |`n"
            foreach ($cert in $expiringCerts) {
                $result += "| $($cert.ProfileName) | $($cert.ExpiryDate) | $($cert.DaysRemaining) |`n"
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