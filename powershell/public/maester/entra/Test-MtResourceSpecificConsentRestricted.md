# Resource-specific consent should be restricted

Resource-specific consent should be restricted to prevent unauthorized access.

## How to fix

Restrict resource-specific consent in the Entra admin center:

1. Go to **Entra ID** → **Security** → **Authentication methods** → **User consent settings**
2. Ensure **Resource-specific consent** is not granted to default user role
3. Or use Microsoft Graph PowerShell:

```powershell
# Remove resource-specific consent policy from default user role
Update-MgPolicyAuthorizationPolicy -PermissionGrantPoliciesAssignedToDefaultUserRole @(
    "ManagePermissionGrantsForSelf.microsoft-user-default-low"
)
```

## Learn more

- [Resource-specific consent](https://learn.microsoft.com/entra/identity-platform/v2-permissions-and-consent#resource-specific-consent)
- [Consent policies](https://learn.microsoft.com/entra/identity/enterprise-apps/configure-user-consent)
- [Resource-specific consent is restricted](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#resource-specific-consent-is-restricted)
