# Service principals should use safe redirect URIs

Service principals should not use insecure redirect URIs (HTTP non-localhost, wildcards).

## How to fix

Update service principals to use safe redirect URIs:

1. Go to **Entra ID** → **Enterprise applications**
2. For each app with unsafe redirect URIs:
   - Go to **Authentication** (or **Single sign-on** → **Reply URLs**)
   - **Reply URLs**: Remove unsafe URIs (HTTP non-localhost, wildcards)
   - Add safe redirect URIs (HTTPS, or HTTP only for localhost/127.0.0.1)
   - **Save**

## Learn more

- [Redirect URI restrictions](https://learn.microsoft.com/entra/identity-platform/reply-url#redirect-uri-restrictions)
- [Enterprise app reply URLs](https://learn.microsoft.com/entra/identity/enterprise-apps/configure-saml-single-sign-on#reply-url)
- [Service principals use safe redirect URIs](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#service-principals-use-safe-redirect-uris)
