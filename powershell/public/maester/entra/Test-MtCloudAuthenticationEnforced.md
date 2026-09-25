# Cloud authentication should be enforced (no federated domains)

Federated domains use on-premises identity providers which can introduce security risks if compromised. Cloud authentication (managed domains) is recommended.

## How to fix

Convert federated domains to managed (cloud) authentication:

1. Go to **Entra ID** → **Custom domain names**
2. For each federated domain, select **Convert to managed**
3. Follow the conversion wizard

Alternatively, use Microsoft Graph PowerShell:

```powershell
# This requires careful planning as it affects all users in the domain
Set-MgDomain -DomainId "contoso.com" -AuthenticationType "Managed"
```

## Learn more

- [Convert federated domain to managed](https://learn.microsoft.com/entra/identity/hybrid/connect/how-to-connect-convert-federated-to-managed)
- [Domain authentication types](https://learn.microsoft.com/entra/identity/hybrid/connect/plan-connect-user-signin)
- [Use cloud authentication](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#use-cloud-authentication)
