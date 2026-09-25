function Test-MtIdProtectionNotificationsEnabled {
    <#
    .SYNOPSIS
    Checks if ID Protection notifications are enabled.

    .DESCRIPTION
    ID Protection notifications should be enabled to alert administrators of risky users,
    risky sign-ins, and other identity protection events. This test verifies that
    notifications are configured.

    .EXAMPLE
    Test-MtIdProtectionNotificationsEnabled

    Returns true if ID Protection notifications are enabled.

    .LINK
    https://maester.dev/docs/commands/Test-MtIdProtectionNotificationsEnabled
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get ID Protection notification settings
        $notificationSettings = Invoke-MtGraphRequest -RelativeUri 'identityProtection/riskDetectionNotificationSettings' -ErrorAction SilentlyContinue

        $notificationsEnabled = $false

        if ($notificationSettings -and $notificationSettings.value) {
            foreach ($setting in $notificationSettings.value) {
                if ($setting.isEnabled -eq $true) {
                    $notificationsEnabled = $true
                    break
                }
            }
        }

        $return = $notificationsEnabled

        if ($return) {
            $testResultMarkdown = 'Well done. ID Protection notifications are enabled.'
        } else {
            $testResultMarkdown = 'ID Protection notifications are not enabled. Notifications should be configured to alert administrators of identity risks.'
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}