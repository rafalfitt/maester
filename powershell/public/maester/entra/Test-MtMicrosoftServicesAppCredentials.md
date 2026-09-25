# Microsoft first-party service principals should not have credentials configured

Microsoft first-party service principals (Microsoft services) should not have client secrets or certificates configured as they are managed by Microsoft.

## How to fix

If Microsoft first-party service principals have credentials configured, this could indicate a security issue. Microsoft manages these applications and their credentials. If you find credentials on Microsoft-owned service principals, you should:

1. Verify if these are legitimate Microsoft-managed credentials
2. Contact Microsoft Support if you believe there's an issue
3. Do not attempt to modify or delete Microsoft-managed credentials

## Learn more

- [Microsoft first-party applications](https://learn.microsoft.com/entra/identity/enterprise-apps/manage-apps#microsoft-first-party-applications)
- [Service principal credentials](https://learn.microsoft.com/entra/identity-platform/service-principal-object)
- [Microsoft services applications don't have credentials configured](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#microsoft-services-applications-dont-have-credentials-configured)
