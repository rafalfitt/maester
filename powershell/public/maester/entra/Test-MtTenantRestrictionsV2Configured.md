# Tenant Restrictions v2 policy should be configured

Tenant Restrictions v2 controls which tenants users can access and should be configured.

## How to fix

Configure Tenant Restrictions v2 in the Entra admin center:

1. Go to **Entra ID** → **Security** → **Tenant restrictions** (Preview)
2. Enable **Tenant restrictions**
3. Configure **Allowed tenants** (list of tenant IDs users can access)
4. Configure **Blocked tenants** (optional)
5. Set **Enforcement mode** to **Enforce**
6. **Save**

## Learn more

- [Tenant Restrictions v2](https://learn.microsoft.com/entra/identity/multi-tenant-organizations/tenant-restrictions-v2)
- [Configure tenant restrictions](https://learn.microsoft.com/entra/identity/multi-tenant-organizations/how-to-tenant-restrictions-v2)
- [Tenant restrictions v2 policy is configured](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#tenant-restrictions-v2-policy-is-configured)
