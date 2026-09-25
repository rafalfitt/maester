# Administrators should be blocked from using SSPR

Administrators should be blocked from using Self-Service Password Reset (SSPR) to prevent attackers from resetting passwords on compromised admin accounts.

## How to fix

Block administrators from using SSPR in the Entra admin center:

1. Go to **Entra ID** → **Security** → **Authentication methods** → **Password reset**
2. Under **Properties**, set **Administrators blocked from SSPR** = **Yes**
3. Save the configuration

Alternatively, use Microsoft Graph PowerShell:

```powershell
Update-MgPolicySelfServicePasswordResetPolicy -AuthorizationPolicy @{
    administratorsBlockedFromSspr = $true
}
```

## Learn more

- [Block administrators from SSPR](https://learn.microsoft.com/entra/identity/authentication/concept-sspr-policy#administrator-reset-policy-differences)
- [SSPR policy configuration](https://learn.microsoft.com/entra/identity/authentication/howto-sspr-deployment)
- [Block administrators from using SSPR](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#block-administrators-from-using-sspr)
