# Directory sync account should be locked down to specific named location

The directory synchronization account (Entra Connect sync account) should only be allowed to sign in from specific named locations (IP ranges) to prevent unauthorized access.

## How to fix

Create a Conditional Access policy that restricts the directory sync account:

1. Go to **Entra ID** → **Security** → **Conditional Access** → **New policy**
2. **Name**: "Restrict Directory Sync Account"
3. **Assignments** → **Users** → **Select users** → Search for "On-Premises Directory Synchronization Service Account"
4. **Target resources** → **All cloud apps**
5. **Conditions** → **Locations** → **Include** → **Select locations** → Choose your named locations (IP ranges)
6. **Access controls** → **Grant** → **Block access** (for locations NOT in the named locations)
7. **Enable policy** = **On**
8. **Create**

## Learn more

- [Named locations in Conditional Access](https://learn.microsoft.com/entra/identity/conditional-access/location-condition)
- [Directory synchronization accounts](https://learn.microsoft.com/entra/identity/hybrid/connect/concept-azure-ad-connect-sync-service-principal)
- [Directory sync account is locked down to specific named location](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#directory-sync-account-is-locked-down-to-specific-named-location)
