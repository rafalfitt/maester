# App registrations should use safe redirect URIs

App registrations should not use insecure redirect URIs (HTTP non-localhost, wildcards).

## How to fix

Update app registrations to use safe redirect URIs:

1. Go to **Entra ID** → **App registrations**
2. For each app with unsafe redirect URIs:
   - Go to **Authentication**
   - **Redirect URIs**: Remove unsafe URIs (HTTP non-localhost, wildcards)
   - Add safe redirect URIs (HTTPS, or HTTP only for localhost/127.0.0.1)
   - **Save**

## Learn more

- [Redirect URI restrictions](https://learn.microsoft.com/entra/identity-platform/reply-url#redirect-uri-restrictions)
- [Secure redirect URIs](https://learn.microsoft.com/entra/identity-platform/secure-redirect-uris)
- [App registrations use safe redirect URIs](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#app-registrations-use-safe-redirect-uris)
