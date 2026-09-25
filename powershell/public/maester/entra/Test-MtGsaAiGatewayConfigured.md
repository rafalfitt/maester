# AI Gateway should be configured to protect enterprise generative AI applications

AI Gateway protects enterprise generative AI applications from prompt injection attacks.

## How to fix

Configure AI Gateway in the Entra admin center:

1. Go to **Entra ID** → **Global Secure Access** → **AI Gateway** (Preview)
2. Enable **AI Gateway**
3. Configure **Protected applications** (add your generative AI apps)
4. Configure **Prompt injection protection** settings
5. **Save**

## Learn more

- [GSA AI Gateway](https://learn.microsoft.com/entra/global-secure-access/ai-gateway)
- [Prompt injection protection](https://learn.microsoft.com/entra/global-secure-access/ai-gateway-prompt-injection)
- [AI Gateway protects enterprise generative AI applications from prompt injection attacks](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#ai-gateway-protects-enterprise-generative-ai-applications-from-prompt-injection-attacks)
