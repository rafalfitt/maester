# App registrations should not have dangling or abandoned domain redirect URIs

App registrations should not have redirect URIs pointing to domains that no longer exist or are not controlled by the organization.

## How to fix

Remove or update dangling redirect URIs:

1. Go to **Entra ID** → **App registrations**
2. For each app with dangling redirect URIs:
   - Go to **Authentication**
   - **Redirect URIs**: Remove URIs pointing to non-existent domains
   - Add redirect URIs for current, controlled domains
   - **Save**

## Learn more

- [Redirect URI management](https://learn.microsoft.com/entra/identity-platform/reply-url)
- [Domain verification](https://learn.microsoft.com/entra/fundamentals/add-custom-domain)
- [App registrations must not have dangling or abandoned domain redirect URIs](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#app-registrations-must-not-have-dangling-or-abandoned-domain-redirect-uris)
