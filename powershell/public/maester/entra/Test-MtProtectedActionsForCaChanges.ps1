function Test-MtProtectedActionsForCaChanges {
    <#
    .SYNOPSIS
    Checks if protected actions are enabled to secure Conditional Access policy creation and changes.

    .DESCRIPTION
    Protected actions require additional authentication (like MFA) before allowing changes to
    Conditional Access policies. This test verifies that protected actions are configured for CA policies.

    .EXAMPLE
    Test-MtProtectedActionsForCaChanges

    Returns true if protected actions are enabled for Conditional Access policy changes.

    .LINK
    https://maester.dev/docs/commands/Test-MtProtectedActionsForCaChanges
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get protected actions configuration
        $protectedActions = @(Invoke-MtGraphRequest -RelativeUri 'policies/authorizationPolicy?$select=protectedActions' -ApiVersion 'beta' -ErrorAction Stop)

        $caProtected = $false

        if ($protectedActions -and $protectedActions.protectedActions) {
            foreach ($action in $protectedActions.protectedActions) {
                if ($action.action -like '*conditionalAccess*' -and $action.isEnabled -eq $true) {
                    $caProtected = $true
                    break
                }
            }
        }

        $return = $caProtected

        if ($return) {
            $testResultMarkdown = 'Well done. Protected actions are enabled for Conditional Access policy changes.'
        } else {
            $testResultMarkdown = 'Protected actions are **not** enabled for Conditional Access policy changes. Changes to CA policies should require additional authentication.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}