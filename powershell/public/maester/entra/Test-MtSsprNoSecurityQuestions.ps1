function Test-MtSsprNoSecurityQuestions {
    <#
    .SYNOPSIS
    Checks if Self-Service Password Reset (SSPR) is configured to not use security questions.

    .DESCRIPTION
    Security questions are considered a weak authentication method for password reset. This test
    verifies that SSPR does not allow security questions as an authentication method.

    .EXAMPLE
    Test-MtSsprNoSecurityQuestions

    Returns true if SSPR does not use security questions.

    .LINK
    https://maester.dev/docs/commands/Test-MtSsprNoSecurityQuestions
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get SSPR policy
        $ssprPolicy = Invoke-MtGraphRequest -RelativeUri 'policies/selfServicePasswordResetPolicy' -ApiVersion 'beta' -ErrorAction Stop

        $usesSecurityQuestions = $false

        if ($ssprPolicy -and $ssprPolicy.authenticationMethodsPolicy) {
            # Check if security questions are enabled
            $usesSecurityQuestions = $ssprPolicy.authenticationMethodsPolicy.securityQuestionsEnabled -eq $true
        }

        $return = -not $usesSecurityQuestions

        if ($return) {
            $testResultMarkdown = 'Well done. Self-Service Password Reset (SSPR) does not use security questions.'
        } else {
            $testResultMarkdown = 'Self-Service Password Reset (SSPR) is configured to use security questions. Security questions are considered a weak authentication method and should be disabled.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}