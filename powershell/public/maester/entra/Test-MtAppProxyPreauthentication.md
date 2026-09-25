# Application Proxy applications should require preauthentication

Application Proxy applications should require Entra ID preauthentication to block anonymous access to on-premises applications.

## How to fix

For each Application Proxy application that allows anonymous access:

1. Go to the Entra admin center → Applications → Enterprise applications
2. Find the Application Proxy application
3. Go to **Application Proxy** → **Settings**
4. Set **Pre-authentication** to **Microsoft Entra ID**
5. Save the configuration

## Learn more

- [Application Proxy pre-authentication](https://learn.microsoft.com/entra/identity/app-proxy/application-proxy-configure-pre-authentication)
- [Publish applications using Application Proxy](https://learn.microsoft.com/entra/identity/app-proxy/application-proxy-add-on-premises-application)
- [Application Proxy applications require preauthentication to block anonymous access](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#application-proxy-applications-require-preauthentication-to-block-anonymous-access)
