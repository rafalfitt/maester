function Test-MtGsaUniversalCaeConfigured {
    <#
    .SYNOPSIS
    Checks if network validation is configured through Universal Continuous Access Evaluation.

    .DESCRIPTION
    Universal CAE provides real-time token validation. This test verifies that network validation
    is configured through Universal CAE.

    .EXAMPLE
    Test-MtGsaUniversalCaeConfigured

    Returns true if Universal CAE network validation is configured.

    .LINK
    https://maester.dev/docs/commands/Test-MtGsaUniversalCaeConfigured
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get CAE configuration
        $caeConfig = Invoke-MtGraphRequest -RelativeUri 'policies/continuousAccessEvaluationPolicy' -ErrorAction SilentlyContinue

        $configured = $false

        if ($caeConfig -and $caeConfig.isEnabled -eq $true) {
            $configured = $true
        }

        $return = $configured

        if ($return) {
            $testResultMarkdown = 'Well done. Universal Continuous Access Evaluation is enabled for network validation.'
        } else {
            $testResultMarkdown = 'Universal Continuous Access Evaluation is not enabled. It provides real-time token validation for network validation.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}