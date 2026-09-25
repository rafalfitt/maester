function Test-MtGsaLicensesAssigned {
    <#
    .SYNOPSIS
    Checks if Global Secure Access licenses are available in the tenant and assigned to users.

    .DESCRIPTION
    GSA licenses must be available and assigned to users for the service to function.
    This test verifies license availability and assignment.

    .EXAMPLE
    Test-MtGsaLicensesAssigned

    Returns true if GSA licenses are available and assigned.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaLicensesAssigned
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get subscribed SKUs for GSA licenses
        $skus = @(Invoke-MtGraphRequest -RelativeUri 'subscribedSkus?$filter=contains(skuPartNumber,\'GLOBAL_SECURE_ACCESS\')' -ErrorAction Stop)

        $licensesAvailable = $false
        $licensesAssigned = $false

        foreach ($sku in $skus) {
            if ($sku.prepaidUnits.enabled -gt 0) {
                $licensesAvailable = $true
                if ($sku.consumedUnits -gt 0) {
                    $licensesAssigned = $true
                }
            }
        }

        $return = $licensesAvailable -and $licensesAssigned

        if ($return) {
            $testResultMarkdown = 'Well done. Global Secure Access licenses are available and assigned to users.'
        } else {
            $issues = @()
            if (-not $licensesAvailable) { $issues += 'No GSA licenses available in tenant' }
            if (-not $licensesAssigned) { $issues += 'GSA licenses available but not assigned to users' }
            $testResultMarkdown = "GSA license issues:`n`n" + ($issues -join "`n")
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}