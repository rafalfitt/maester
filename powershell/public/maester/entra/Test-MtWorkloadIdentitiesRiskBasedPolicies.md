# Workload identities should be configured with risk-based policies

Workload identities should have risk-based Conditional Access policies configured to automatically respond to risk events.

## How to fix

Create risk-based Conditional Access policies for workload identities:

1. Go to **Entra ID** → **Security** → **Conditional Access** → **New policy**
2. **Name**: "Workload Identity Risk Response"
3. **Assignments** → **Workload identities** → **Select workload identities** → Choose service principals/managed identities
4. **Conditions** → **Sign-in risk** → **High** (and optionally Medium)
5. **Access controls** → **Grant** → **Block access** (or require MFA, etc.)
6. **Enable policy** = **On**
7. **Create**

## Learn more

- [Workload identity risk](https://learn.microsoft.com/entra/id-protection/concept-workload-identity-risk)
- [Risk-based CA for workload identities](https://learn.microsoft.com/entra/id-protection/howto-workload-identity-risk-remediation)
- [Workload identities are configured with risk-based policies](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#workload-identities-are-configured-with-risk-based-policies)
