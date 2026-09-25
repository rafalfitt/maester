# ID Protection notifications should be enabled

ID Protection notifications should be enabled to alert administrators of identity risks.

## How to fix

Enable ID Protection notifications in the Entra admin center:

1. Go to **Entra ID** → **Security** → **Identity Protection** → **Notifications**
2. Enable the following notifications:
   - **Users at risk detected** → On
   - **Weekly digest** → On
   - **Risky sign-in alerts** → On
3. Configure **Recipients** (security administrators, global administrators)
4. **Save**

## Learn more

- [ID Protection notifications](https://learn.microsoft.com/entra/id-protection/howto-identity-protection-configure-risk-alerts)
- [Configure risk alerts](https://learn.microsoft.com/entra/id-protection/howto-identity-protection-configure-risk-alerts)
- [ID Protection notifications are enabled](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#id-protection-notifications-are-enabled)
