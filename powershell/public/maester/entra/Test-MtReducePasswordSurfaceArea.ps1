function Test-MtReducePasswordSurfaceArea {
    <#
    .SYNOPSIS
    Checks if the user-visible password surface area is reduced (password hash sync, no password writeback).

    .DESCRIPTION
    This test verifies that password hash synchronization is enabled and password writeback is disabled,
    reducing the attack surface for password-based attacks.

    .EXAMPLE
    Test-MtReducePasswordSurfaceArea

    Returns true if password hash sync is enabled and password writeback is disabled.

    .LINK
    https://maester.dev/docs/commands/Test-MtReducePasswordSurfaceArea
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get Entra Connect sync configuration
        $syncConfig = Invoke-MtGraphRequest -RelativeUri 'onPremisesPublishingProfiles?$filter=type eq \'passwordHashSync\'' -ErrorAction Stop

        $phsEnabled = $false
        $pwWritebackDisabled = $true

        if ($syncConfig -and $syncConfig.value) {
            foreach ($syncProfile in $syncConfig.value) {
                if ($syncProfile.type -eq 'passwordHashSync') {
                    $phsEnabled = $syncProfile.state -eq 'enabled'
                }
            }
        }

        # Check password writeback
        $pwWritebackConfig = Invoke-MtGraphRequest -RelativeUri 'onPremisesPublishingProfiles?$filter=type eq \'passwordWriteback\'' -ErrorAction SilentlyContinue
        if ($pwWritebackConfig -and $pwWritebackConfig.value) {
            foreach ($pwProfile in $pwWritebackConfig.value) {
                if ($pwProfile.type -eq 'passwordWriteback') {
                    $pwWritebackDisabled = $pwProfile.state -ne 'enabled'
                }
            }
        }

        $return = $phsEnabled -and $pwWritebackDisabled

        if ($return) {
            $testResultMarkdown = 'Well done. Password hash sync is enabled and password writeback is disabled, reducing password surface area.'
        } else {
            $issues = @()
            if (-not $phsEnabled) { $issues += 'Password hash synchronization is not enabled' }
            if (-not $pwWritebackDisabled) { $issues += 'Password writeback is enabled (should be disabled)' }
            $testResultMarkdown = "Password surface area not fully reduced:`n`n" + ($issues -join "`n")
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}