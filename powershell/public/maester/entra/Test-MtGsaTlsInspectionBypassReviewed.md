# TLS inspection bypass rules should be regularly reviewed

TLS inspection bypass rules should be regularly reviewed to ensure they are still necessary.

## How to fix

Review TLS inspection bypass rules in the Entra admin center:

1. Go to **Entra ID** → **Global Secure Access** → **Secure Web Gateway** → **TLS inspection**
2. For each TLS inspection profile:
   - Review **Bypass rules**
   - Verify each rule is still necessary
   - Update **Last reviewed** date for each rule
3. Remove any unnecessary bypass rules

## Learn more

- [GSA TLS inspection](https://learn.microsoft.com/entra/global-secure-access/secure-web-gateway/tls-inspection)
- [TLS inspection bypass rules](https://learn.microsoft.com/entra/global-secure-access/secure-web-gateway/tls-inspection-bypass)
- [TLS inspection bypass rules are regularly reviewed](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#tls-inspection-bypass-rules-are-regularly-reviewed)
