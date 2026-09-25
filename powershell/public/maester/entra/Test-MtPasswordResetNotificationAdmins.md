# Password reset notifications should be enabled for administrators

Password reset notifications should be enabled for both administrators and users to detect unauthorized password resets on privileged accounts.

## How to fix

Enable password reset notifications in the Entra admin center:

1. Go to **Entra ID** → **Security** → **Authentication methods** → **Password reset**
2. Under **Notifications**, enable:
   - **Notify users on password resets** = Yes
   - **Notify admins on password resets** = Yes
3. Save the configuration

Alternatively, use Microsoft Graph PowerShell:

```powershell
Update-MgPolicyAuthorizationPolicy -PasswordResetNotificationSettings @{
    notifyAdminsOnPasswordReset = $true
    notifyUsersOnPasswordReset = $true
}
```

## Learn more

- [Password reset notifications](https://learn.microsoft.com/entra/identity/authentication/howto-sspr-notifications)
- [Self-service password reset](https://learn.microsoft.com/entra/identity/authentication/concept-sspr-howitworks)
- [Require password reset notifications for administrator roles](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#require-password-reset-notifications-for-administrator-roles)
