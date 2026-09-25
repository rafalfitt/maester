# Universal tenant restrictions should block unauthorized external tenant access

Universal tenant restrictions should block unauthorized external tenant access.

## How to fix

Configure universal tenant restrictions in the Entra admin center:

1. Go to **Entra ID** → **Global Secure Access** → **Tenant restrictions**
2. Enable **Universal tenant restrictions**
3. Configure **Allowed tenants** list
4. Set **Enforcement mode** to **Enforce**
5. **Save**

## Learn more

- [Universal tenant restrictions](https://learn.microsoft.com/entra/global-secure-access/tenant-restrictions-universal)
- [Configure universal tenant restrictions](https://learn.microsoft.com/entra/global-secure-access/tenant-restrictions-universal-configure)
- [Universal tenant restrictions block unauthorized external tenant access](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#universal-tenant-restrictions-block-unauthorized-external-tenant-access)
