# TLS inspection custom bypass rules should not duplicate system bypass destinations

Custom bypass rules should not duplicate system bypass destinations.

## How to fix

Remove duplicate custom bypass rules:

1. Go to **Entra ID** → **Global Secure Access** → **Secure Web Gateway** → **TLS inspection**
2. For each profile with duplicates:
   - Review **Custom bypass rules**
   - Compare with **System bypass destinations**
   - Remove any custom rules that duplicate system destinations
3. Save the configuration

## Learn more

- [GSA TLS inspection](https://learn.microsoft.com/entra/global-secure-access/secure-web-gateway/tls-inspection)
- [TLS inspection bypass rules](https://learn.microsoft.com/entra/global-secure-access/secure-web-gateway/tls-inspection-bypass)
- [TLS inspection custom bypass rules don't duplicate system bypass destinations](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#tls-inspection-custom-bypass-rules-dont-duplicate-system-bypass-destinations)
