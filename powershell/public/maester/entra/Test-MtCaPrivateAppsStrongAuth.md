# Conditional Access policies should enforce strong authentication for private apps

Conditional Access policies should require phishing-resistant MFA for access to private applications published through Entra Private Access.

## How to fix

Create a Conditional Access policy that:

1. Targets the Private Access applications (or all apps if using Global Secure Access)
2. Requires phishing-resistant authentication methods (FIDO2, Windows Hello for Business, Certificate-based authentication)
3. Is enabled and not in report-only mode

Example policy configuration:

- **Assignments**: Users/Groups → All users (or specific groups)
- **Target resources**: Select Private Access apps or use "All cloud apps" with Private Access
- **Access controls**: Grant → Require multifactor authentication → Select "Phishing-resistant MFA"

## Learn more

- [Entra Private Access Conditional Access](https://learn.microsoft.com/entra/global-secure-access/private-access/conditional-access-private-access)
- [Phishing-resistant authentication methods](https://learn.microsoft.com/entra/authentication/concept-authentication-phishing-resistant)
- [Conditional Access policies enforce strong authentication for private apps](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#conditional-access-policies-enforce-strong-authentication-for-private-apps)
