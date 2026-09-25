# Entra Connect Sync should use Service Principal credentials

Entra Connect Sync should use a Service Principal with certificate-based authentication instead of a user account with password.

## How to fix

Configure Entra Connect to use a Service Principal:

1. Run the **Entra Connect** wizard
2. On the **Microsoft Entra credentials** page, select **Use existing service principal**
3. Provide the Service Principal credentials (certificate)
4. Complete the configuration

Alternatively, use Microsoft Graph PowerShell to create a Service Principal for Entra Connect:

```powershell
# Create a Service Principal for Entra Connect
$sp = New-MgServicePrincipal -AppId "your-app-id" -DisplayName "Entra Connect Sync"
# Configure certificate on the Service Principal
```

## Learn more

- [Entra Connect with Service Principal](https://learn.microsoft.com/entra/identity/hybrid/connect/how-to-connect-install-custom#use-existing-service-principal)
- [Service Principal for Entra Connect](https://learn.microsoft.com/entra/identity/hybrid/connect/concept-azure-ad-connect-sync-service-principal)
- [Entra Connect Sync is configured with Service Principal Credentials](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#entra-connect-sync-is-configured-with-service-principal-credentials)
