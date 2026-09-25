# Conditional Access policies should use compliant network controls

CA policies should reference GSA compliant network for access decisions.

## How to fix

Update Conditional Access policies to use compliant network controls:

1. Go to **Entra ID** → **Security** → **Conditional Access**
2. Edit policies that should require compliant network
3. **Conditions** → **Network** → **Include** → **Compliant network**
4. **Save**

## Learn more

- [GSA compliant network](https://learn.microsoft.com/entra/global-secure-access/compliant-network)
- [CA network conditions](https://learn.microsoft.com/entra/identity/conditional-access/concept-conditional-access-conditions#network)
- [Conditional Access policies use compliant network controls](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#conditional-access-policies-use-compliant-network-controls)
