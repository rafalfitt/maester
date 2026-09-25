# TLS inspection failure rate should be below 1%

High TLS inspection failure rates can indicate configuration issues.

## How to fix

Investigate and resolve high TLS inspection failure rates:

1. Go to **Entra ID** → **Global Secure Access** → **Secure Web Gateway** → **TLS inspection**
2. Check the **Metrics** for each profile
3. For profiles with high failure rates:
   - Review bypass rules
   - Check certificate configuration
   - Verify network connectivity
   - Check for incompatible applications
4. Adjust configuration as needed

## Learn more

- [GSA TLS inspection](https://learn.microsoft.com/entra/global-secure-access/secure-web-gateway/tls-inspection)
- [TLS inspection troubleshooting](https://learn.microsoft.com/entra/global-secure-access/secure-web-gateway/tls-inspection-troubleshoot)
- [TLS inspection failure rate is below 1%](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#tls-inspection-failure-rate-is-below-1)
