# Token protection policies should be configured

Token protection binds sign-in tokens to the device, preventing token theft and replay attacks.

## How to fix

Configure token protection policies in the Entra admin center:

1. Go to **Entra ID** → **Security** → **Conditional Access** → **Authentication strengths**
2. Create a new authentication strength policy that includes token protection
3. Apply the policy to Conditional Access policies

Alternatively, use Microsoft Graph PowerShell:

```powershell
# Create authentication strength policy with token protection
New-MgPolicyAuthenticationStrengthPolicy -DisplayName "Token Protection" -AuthenticationMethodCombinations @(@("TokenProtection"))
```

## Learn more

- [Token protection](https://learn.microsoft.com/entra/identity/conditional-access/concept-token-protection)
- [Authentication strengths](https://learn.microsoft.com/entra/identity/conditional-access/concept-authentication-strengths)
- [Token protection policies are configured](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#token-protection-policies-are-configured)
