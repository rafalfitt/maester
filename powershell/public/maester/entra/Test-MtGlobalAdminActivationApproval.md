# Global Administrator role activation should trigger an approval workflow

Global Administrator role activations should require approval through PIM.

## How to fix

Configure approval workflow for Global Administrator role in PIM:

1. Go to **Entra ID** → **Privileged Identity Management** → **Roles** → **Global Administrator**
2. Click **Settings** → **Edit**
3. Enable **Require approval to activate**
4. Select **Approvers** (users or groups)
5. Set **Approval timeout** (e.g., 24 hours)
6. **Save**

## Learn more

- [PIM approval workflow](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings#require-approval)
- [Global Administrator role settings](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-add-role-to-user#make-a-user-eligible-for-a-role)
- [Global Administrator role activation triggers an approval workflow](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#global-administrator-role-activation-triggers-an-approval-workflow)
