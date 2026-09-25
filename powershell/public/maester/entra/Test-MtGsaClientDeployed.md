# Global Secure Access client should be deployed on all managed endpoints

The GSA client is required for network traffic inspection on managed endpoints.

## How to fix

Deploy the GSA client to managed endpoints:

1. Go to **Entra ID** → **Global Secure Access** → **Client deployment**
2. Configure **Deployment settings**
3. Assign to **Managed devices** (Intune-managed)
4. **Deploy**

## Learn more

- [GSA client deployment](https://learn.microsoft.com/entra/global-secure-access/client-deployment)
- [Managed endpoint requirements](https://learn.microsoft.com/entra/global-secure-access/client-deployment-managed)
