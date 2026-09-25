# App instance property lock should be configured for all multitenant applications

App instance property lock prevents unauthorized changes to multitenant application properties by locking them to the home tenant.

## How to fix

Enable app instance property lock for multitenant applications:

1. Go to **Entra ID** → **Applications** → **Enterprise applications**
2. For each multitenant application (owned by another organization):
   - Go to **Properties**
   - Enable **App instance property lock** (if available)
3. Alternatively, use Microsoft Graph PowerShell:

```powershell
# Add the property lock tag to the service principal
Update-MgServicePrincipal -ServicePrincipalId "sp-id" -Tags @("AppInstancePropertyLockEnabled")
```

## Learn more

- [App instance property lock](https://learn.microsoft.com/entra/identity/enterprise-apps/app-instance-property-lock)
- [Multitenant application security](https://learn.microsoft.com/entra/identity/enterprise-apps/manage-apps#multitenant-applications)
- [App instance property lock is configured for all multitenant applications](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#app-instance-property-lock-is-configured-for-all-multitenant-applications)
