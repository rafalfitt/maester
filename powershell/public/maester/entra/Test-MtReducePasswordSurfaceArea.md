# User-visible password surface area should be reduced

Password hash synchronization should be enabled and password writeback disabled to reduce the attack surface for password-based attacks.

## How to fix

Configure Entra Connect to use password hash synchronization and disable password writeback:

1. Run the **Entra Connect** wizard
2. Select **Password hash synchronization** as the sign-in method
3. Ensure **Password writeback** is **not** selected
4. Complete the configuration

Alternatively, use Microsoft Graph PowerShell:

```powershell
# This is configured through Entra Connect, not directly via Graph API
# Verify configuration in Entra admin center:
# Entra ID -> Hybrid management -> Entra Connect sync
```

## Learn more

- [Password hash synchronization](https://learn.microsoft.com/entra/identity/hybrid/connect/whatis-phs)
- [Password writeback](https://learn.microsoft.com/entra/identity/hybrid/connect/how-to-connect-password-writeback)
- [Reduce the user-visible password surface area](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#reduce-the-user-visible-password-surface-area)
