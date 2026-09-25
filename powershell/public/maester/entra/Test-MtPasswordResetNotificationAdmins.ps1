function Test-MtPasswordResetNotificationAdmins {
    <#
    .SYNOPSIS
    Checks if password reset notifications are enabled for administrator roles.

    .DESCRIPTION
    This test verifies that when a password is reset for a user with an administrator role, a notification
    is sent to the user and/or other administrators. This helps detect unauthorized password resets on
    privileged accounts.

    .EXAMPLE
    Test-MtPasswordResetNotificationAdmins

    Returns true if password reset notifications are enabled for administrators.

    .LINK
    https://maester.dev/docs/commands/Test-MtPasswordResetNotificationAdmins
    #>
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    if (-not (Test-MtConnection Graph)) {
        Add-MtTestResultDetail -SkippedBecause NotConnectedGraph
        return $null
    }

    try {
        # Get the password reset notification settings from authorization policy
        $authPolicy = Invoke-MtGraphRequest -RelativeUri 'policies/authorizationPolicy?$select=passwordResetNotificationSettings' -ApiVersion 'beta' -ErrorAction Stop

        $notifyAdmins = $false
        $notifyUsers = $false

        if ($authPolicy.passwordResetNotificationSettings) {
            $notifyAdmins = $authPolicy.passwordResetNotificationSettings.notifyAdminsOnPasswordReset -eq $true
            $notifyUsers = $authPolicy.passwordResetNotificationSettings.notifyUsersOnPasswordReset -eq $true
        }

        $return = $notifyAdmins -and $notifyUsers

        if ($return) {
            $testResultMarkdown = 'Well done. Password reset notifications are enabled for both administrators and users.'
        } else {
            $issues = @()
            if (-not $notifyAdmins) { $issues += 'Administrators are not notified on password reset' }
            if (-not $notifyUsers) { $issues += 'Users are not notified on password reset' }

            $testResultMarkdown = "Password reset notifications are not fully configured:`n`n" + ($issues -join "`n")
        }

        Add-MtTestResultDetail -Result $testResultMarkdown
        return $return
    } catch {
        Add-MtTestResultDetail -SkippedBecause Error -SkippedError $_
        return $null
    }
}