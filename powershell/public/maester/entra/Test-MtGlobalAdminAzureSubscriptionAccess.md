# Global Administrators should not have standing access to Azure subscriptions

Global Administrators should not have standing (permanent) access to Azure subscriptions. Access should be granted through PIM or just-in-time.

## How to fix

Remove standing Azure subscription access for Global Administrators:

1. Go to **Azure Portal** → **Subscriptions** → **Access control (IAM)**
2. For each subscription, review **Role assignments**
3. Find Global Administrators with **Owner**, **Contributor**, or other privileged roles
4. **Remove** these role assignments
5. Configure **PIM for Azure Resources** for just-in-time access:
   - Go to **Entra ID** → **Privileged Identity Management** → **Azure Resources**
   - Discover and onboard subscriptions
   - Configure eligible assignments for Global Admins
   - Require approval and MFA for activation

## Learn more

- [PIM for Azure Resources](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-resource-roles-overview)
- [Azure subscription access control](https://learn.microsoft.com/azure/role-based-access-control/overview)
- [Global Administrators don't have standing access to Azure subscriptions](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#global-administrators-dont-have-standing-access-to-azure-subscriptions)
