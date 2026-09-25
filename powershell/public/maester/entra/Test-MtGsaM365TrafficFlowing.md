# Microsoft 365 traffic should be actively flowing through Global Secure Access

M365 traffic should be routed through GSA for security policy enforcement.

## How to fix

Route M365 traffic through GSA:

1. Go to **Entra ID** → **Global Secure Access** → **Traffic forwarding**
2. Enable **Microsoft 365 traffic forwarding**
3. Configure **Forwarding profile** for M365
4. Assign to **Users/Groups**
5. **Save**

## Learn more

- [GSA M365 traffic forwarding](https://learn.microsoft.com/entra/global-secure-access/secure-web-gateway/m365-traffic-forwarding)
- [Traffic forwarding profiles](https://learn.microsoft.com/entra/global-secure-access/secure-web-gateway/forwarding-profiles)
