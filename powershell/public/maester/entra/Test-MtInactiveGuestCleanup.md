# Inactive guest identities should be disabled or removed

Inactive guest users should be disabled or removed to reduce the attack surface.

## How to fix

Disable or remove inactive guest users:

1. Go to **Entra ID** → **Users** → **All users**
2. Filter by **User type** = **Guest**
3. Sort by **Last sign-in** to find inactive users
4. For each inactive guest user:
   - Go to **Properties** → **Account enabled** = **No** (to disable)
   - Or **Delete** the user (to remove)
5. Alternatively, use Microsoft Graph PowerShell:

```powershell
# Disable inactive guest user
Update-MgUser -UserId "guest-user-id" -AccountEnabled $false
# Or remove
Remove-MgUser -UserId "guest-user-id"
```

## Learn more

- [Manage inactive guest users](https://learn.microsoft.com/entra/external-id/users/guest-user-permissions)
- [Guest user lifecycle](https://learn.microsoft.com/entra/external-id/users/guest-user-permissions#guest-user-lifecycle)
- [Inactive guest identities are disabled or removed from the tenant](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#inactive-guest-identities-are-disabled-or-removed-from-the-tenant)
