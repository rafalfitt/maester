# Named locations should be configured

Named locations define trusted IP ranges or countries for use in Conditional Access policies.

## How to fix

Create named locations in the Entra admin center:

1. Go to **Entra ID** → **Security** → **Conditional Access** → **Named locations**
2. Click **New location**
3. **Name**: Enter a descriptive name (e.g., "Corporate Network")
4. **Type**: Select **IP ranges** or **Countries**
5. For IP ranges: Add your trusted IP ranges (CIDR notation)
6. For Countries: Select trusted countries
7. **Mark as trusted** if this is a trusted location
8. **Create**

## Learn more

- [Named locations in Conditional Access](https://learn.microsoft.com/entra/identity/conditional-access/location-condition)
- [Configure named locations](https://learn.microsoft.com/entra/identity/conditional-access/howto-conditional-access-policy-location)
- [Named locations are configured](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#named-locations-are-configured)
