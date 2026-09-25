# Legacy Entra Connect user-type service accounts with high privileges should not exist

Legacy Entra Connect user-type service accounts with high privileges should be migrated to Service Principal-based authentication.

## How to fix

Migrate legacy Entra Connect service accounts to Service Principal:

1. **Create a new Service Principal** for Entra Connect:
   - Go to **Entra ID** → **App registrations** → **New registration**
   - Name: "Entra Connect Sync Service Principal"
   - Supported account types: **Accounts in this organizational directory only**
   - **Register**

2. **Configure certificate authentication** on the Service Principal:
   - Go to **Certificates & secrets** → **Certificates** → **Upload certificate**
   - Upload your Entra Connect certificate

3. **Grant necessary permissions** to the Service Principal:
   - **Microsoft Graph** → **Application permissions**:
     - `Directory.ReadWrite.All`
     - `User.ReadWrite.All`
     - `Group.ReadWrite.All`
     - `Application.ReadWrite.All`
   - **Grant admin consent**

4. **Update Entra Connect configuration**:
   - Run **Entra Connect wizard** → **Configure** → **Use existing service principal**
   - Provide the Service Principal App ID and certificate

5. **Disable/remove legacy user accounts**:
   - Go to **Entra ID** → **Users**
   - Find legacy sync accounts (displayName starting with "On-Premises Directory Synchronization" or UPN starting with "sync_" or "ADSync")
   - **Disable** or **Delete** these accounts

## Learn more

- [Entra Connect with Service Principal](https://learn.microsoft.com/entra/identity/hybrid/connect/how-to-connect-install-custom#use-existing-service-principal)
- [Migrate from user account to Service Principal](https://learn.microsoft.com/entra/identity/hybrid/connect/concept-azure-ad-connect-sync-service-principal)
- [Entra Connect service principal permissions](https://learn.microsoft.com/entra/identity/hybrid/connect/concept-azure-ad-connect-sync-service-principal#permissions)
- [Entra Connect Sync is configured with Service Principal Credentials](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#entra-connect-sync-is-configured-with-service-principal-credentials)
