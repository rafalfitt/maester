# Enterprise applications should require explicit assignment or scoped provisioning

Enterprise applications should require explicit user assignment or scoped provisioning to prevent unauthorized access.

## How to fix

Enable assignment required for enterprise applications:

1. Go to **Entra ID** → **Enterprise applications**
2. For each application:
   - Go to **Properties**
   - Set **Assignment required?** = **Yes**
   - **Save**
3. Then assign users/groups:
   - Go to **Users and groups**
   - **Add user/group** → Select users/groups → **Assign**

## Learn more

- [Assignment required](https://learn.microsoft.com/entra/identity/enterprise-apps/assign-user-or-group-access-portal#configure-an-application-to-require-user-assignment)
- [Scoped provisioning](https://learn.microsoft.com/entra/identity/enterprise-apps/configure-automatic-user-provisioning)
- [Enterprise applications must require explicit assignment or scoped provisioning](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#enterprise-applications-must-require-explicit-assignment-or-scoped-provisioning)
