function Test-MtTokenProtectionPolicyEnabled {
    <#
    .SYNOPSIS
    Checks if token protection policies are configured.

    .DESCRIPTION
    Token protection binds sign-in tokens to the device, preventing token theft and replay attacks.
    This test verifies that token protection policies are configured for the tenant.

    .EXAMPLE
    Test-MtTokenProtectionPolicyEnabled

    Returns true if token protection policies are configured.

    .LINK
    https://maester.dev/docs/commands/Test-MtTokenProtectionPolicyEnabled
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get token protection policies
        $tokenProtectionPolicies = @(Invoke-MtGraphRequest -RelativeUri 'policies/tokenLifetimePolicies?$filter=definition contains \'TokenProtection\'' -ErrorAction Stop)

        # Also check authentication strength policies for token protection
        $authStrengthPolicies = @(Invoke-MtGraphRequest -RelativeUri 'policies/authenticationStrengthPolicies' -ErrorAction Stop)

        $hasTokenProtection = $false

        if ($tokenProtectionPolicies.Count -gt 0) {
            $hasTokenProtection = $true
        } elseif ($authStrengthPolicies.Count -gt 0) {
            foreach ($policy in $authStrengthPolicies) {
                if ($policy.authenticationMethodCombinations) {
                    foreach ($combo in $policy.authenticationMethodCombinations) {
                        if ($combo -like '*TokenProtection*') {
                            $hasTokenProtection = $true
                            break
                        }
                    }
                }
                if ($hasTokenProtection) { break }
            }
        }

        $return = $hasTokenProtection

        if ($return) {
            $testResultMarkdown = 'Well done. Token protection policies are configured.'
        } else {
            $testResultMarkdown = 'No token protection policies found. Token protection binds sign-in tokens to the device, preventing token theft and replay attacks.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}