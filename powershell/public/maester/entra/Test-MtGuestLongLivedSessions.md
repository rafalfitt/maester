# Guest users should not have long-lived sign-in sessions

Guest users should have sign-in frequency or persistent browser session controls configured to limit session duration.

## How to fix

Configure Conditional Access policies for guest users:

1. Go to **Entra ID** → **Security** → **Conditional Access** → **New policy**
2. **Name**: "Guest Session Controls"
3. **Assignments** → **Users** → **Guest or external users** → **All guest users**
4. **Target resources** → **All cloud apps**
5. **Access controls** → **Session** → **Sign-in frequency** → Set to **1 hour** (or appropriate value)
6. **Access controls** → **Session** → **Persistent browser session** → **Never persistent**
7. **Enable policy** = **On**
8. **Create**

## Learn more

- [Guest access session controls](https://learn.microsoft.com/entra/identity/conditional-access/howto-conditional-access-session-lifetime)
- [Sign-in frequency](https://learn.microsoft.com/entra/identity/conditional-access/concept-conditional-access-session-lifetime#sign-in-frequency)
- [Guests don't have long-lived sign-in sessions](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#guests-dont-have-long-lived-sign-in-sessions)
