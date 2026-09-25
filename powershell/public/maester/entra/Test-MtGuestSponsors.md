# All guest users should have a sponsor assigned

All guest users should have a sponsor assigned for accountability and access reviews.

## How to fix

Assign sponsors to guest users:

1. Go to **Entra ID** → **Users** → **All users**
2. Filter by **User type** = **Guest**
3. For each guest user without a sponsor:
   - Go to **Manager** (or **Sponsor** if available)
   - Assign an internal user as sponsor/manager
4. Alternatively, use Microsoft Graph PowerShell:

```powershell
# Assign sponsor/manager to guest user
Update-MgUser -UserId "guest-user-id" -Manager @{ "@odata.id" = "https://graph.microsoft.com/v1.0/users/sponsor-user-id" }
```

## Learn more

- [Guest user sponsors](https://learn.microsoft.com/entra/external-id/users/guest-user-permissions#guest-user-sponsors)
- [Manage guest access](https://learn.microsoft.com/entra/external-id/users/guest-user-permissions)
- [All guests have a sponsor](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#all-guests-have-a-sponsor)
