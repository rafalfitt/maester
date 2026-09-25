# Internet traffic should be inspected across all Secure Web Gateway defense layers

Internet traffic should be inspected across all SWG defense layers (URL filtering, malware scanning, TLS inspection, threat intelligence).

## How to fix

Enable all SWG defense layers in the Entra admin center:

1. Go to **Entra ID** → **Global Secure Access** → **Secure Web Gateway**
2. Enable each defense layer:
   - **URL Filtering** → Enable
   - **Malware Scanning** → Enable
   - **TLS Inspection** → Enable
   - **Threat Intelligence** → Enable
3. Configure each layer as needed
4. **Save**

## Learn more

- [GSA Secure Web Gateway](https://learn.microsoft.com/entra/global-secure-access/secure-web-gateway)
- [SWG defense layers](https://learn.microsoft.com/entra/global-secure-access/secure-web-gateway/defense-layers)
- [Internet traffic is inspected across all Secure Web Gateway defense layers](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#internet-traffic-is-inspected-across-all-secure-web-gateway-defense-layers)
