# Protected actions should be enabled for Conditional Access policy changes

Protected actions require additional authentication before allowing changes to Conditional Access policies, preventing unauthorized modifications.

## How to fix

Enable protected actions for Conditional Access in the Entra admin center:

1. Go to **Entra ID** → **Security** → **Protected actions** (Preview)
2. Find **Conditional Access policy management** actions
3. Enable **Require authentication** for:
   - Create Conditional Access policy
   - Update Conditional Access policy
   - Delete Conditional Access policy
4. Configure the authentication method (MFA, etc.)
5. Save

## Learn more

- [Protected actions in Entra ID](https://learn.microsoft.com/entra/identity/conditional-access/concept-protected-actions)
- [Secure Conditional Access changes](https://learn.microsoft.com/entra/identity/conditional-access/howto-protected-actions)
- [Enable protected actions to secure Conditional Access policy creation and changes](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#enable-protected-actions-to-secure-conditional-access-policy-creation-and-changes)
