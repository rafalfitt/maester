# SSPR should not use security questions

Security questions are a weak authentication method for password reset and should be disabled in SSPR policy.

## How to fix

Disable security questions in SSPR policy in the Entra admin center:

1. Go to **Entra ID** → **Security** → **Authentication methods** → **Password reset**
2. Under **Authentication methods**, set **Security questions** = **No**
3. Save the configuration

Alternatively, use Microsoft Graph PowerShell:

```powershell
Update-MgPolicySelfServicePasswordResetPolicy -AuthenticationMethodsPolicy @{
    securityQuestionsEnabled = $false
}
```

## Learn more

- [SSPR authentication methods](https://learn.microsoft.com/entra/identity/authentication/concept-sspr-policy#authentication-methods)
- [Security questions in SSPR](https://learn.microsoft.com/entra/identity/authentication/concept-sspr-policy#security-questions)
- [Self-service password reset doesn't use security questions](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#self-service-password-reset-doesnt-use-security-questions)
