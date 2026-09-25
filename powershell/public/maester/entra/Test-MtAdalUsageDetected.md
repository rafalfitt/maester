# No ADAL usage should be detected in the tenant

ADAL (Azure AD Authentication Library) has been deprecated and replaced by MSAL. Applications should be migrated to MSAL.

## How to fix

Identify and migrate applications using ADAL to MSAL:

1. Review the sign-in logs for applications using ADAL (this test shows them)
2. For each application, update the authentication library from ADAL to MSAL
3. Test the application with MSAL
4. Deploy the updated application

## Learn more

- [ADAL deprecation](https://learn.microsoft.com/entra/identity-platform/msal-migration)
- [Migrate from ADAL to MSAL](https://learn.microsoft.com/entra/identity-platform/msal-migration)
- [MSAL libraries](https://learn.microsoft.com/entra/identity-platform/msal-overview)
- [No usage of ADAL in the tenant](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#no-usage-of-adal-in-the-tenant)
