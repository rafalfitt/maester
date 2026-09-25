# TLS inspection certificates should have sufficient validity period

TLS inspection certificates should have sufficient validity period to avoid service disruption.

## How to fix

Renew TLS inspection certificates before they expire:

1. Go to **Entra ID** → **Global Secure Access** → **Secure Web Gateway** → **TLS inspection**
2. For each expiring certificate:
   - Generate a new certificate
   - Update the TLS inspection profile with the new certificate
   - Verify the configuration works
3. Set up monitoring/alerts for certificate expiry

## Learn more

- [GSA TLS inspection](https://learn.microsoft.com/entra/global-secure-access/secure-web-gateway/tls-inspection)
- [Manage TLS inspection certificates](https://learn.microsoft.com/entra/global-secure-access/secure-web-gateway/tls-inspection-certificates)
- [TLS inspection certificates have a sufficient validity period](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#tls-inspection-certificates-have-a-sufficient-validity-period)
