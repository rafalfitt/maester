# Guest users should not own applications in the tenant

Guest users should not own applications as this could lead to unauthorized access or privilege escalation.

## How to fix

Remove guest users as owners of applications:

1. Go to **Entra ID** → **Applications** → **Enterprise applications**
2. For each application owned by a guest user:
   - Go to **Owners**
   - Remove the guest user
   - Add an appropriate internal user or group as owner
3. Alternatively, use Microsoft Graph PowerShell:

```powershell
# Remove guest owner
Remove-MgApplicationOwnerByRef -ApplicationId "app-id" -OwnerId "guest-user-id"
# Add internal owner
Add-MgApplicationOwner -ApplicationId "app-id" -BodyParameter @{ "@odata.id" = "https://graph.microsoft.com/v1.0/users/internal-user-id" }
```

## Learn more

- [Application ownership](https://learn.microsoft.com/entra/identity/enterprise-apps/manage-apps#application-ownership)
- [Guest user permissions](https://learn.microsoft.com/entra/external-id/users/guest-user-permissions)
- [Guests don't own apps in the tenant](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#guests-dont-own-apps-in-the-tenant)
