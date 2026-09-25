# File transfer policies should be configured to prevent data exfiltration

File transfer policies can prevent data exfiltration by controlling file uploads/downloads.

## How to fix

Configure file transfer policies in the Entra admin center:

1. Go to **Entra ID** → **Global Secure Access** → **Secure Web Gateway** → **File transfer policies**
2. Click **Create policy**
3. **Name**: Enter a descriptive name
4. **Action**: Select **Block** or **Monitor**
5. **File types**: Select file types to control
6. **Size limits**: Configure upload/download size limits
7. **Assignments**: Assign to users/groups
8. **Enable** and **Create**

## Learn more

- [GSA file transfer policies](https://learn.microsoft.com/entra/global-secure-access/secure-web-gateway/file-transfer-policies)
- [Data exfiltration prevention](https://learn.microsoft.com/entra/global-secure-access/secure-web-gateway/data-exfiltration-prevention)
- [File transfer policies are configured to prevent data exfiltration](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#file-transfer-policies-are-configured-to-prevent-data-exfiltration)
