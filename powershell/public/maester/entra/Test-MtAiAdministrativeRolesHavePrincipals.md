# AI administrative roles should have assigned principals

AI administrative roles should have assigned principals for accountability.

## How to fix

Assign principals to AI administrative roles in the Entra admin center:

1. Go to **Entra ID** → **Privileged Identity Management** → **Roles**
2. Search for AI administrative roles:
   - **AI Administrator**
   - **AI Developer**
   - **AI Operator**
3. For each role without assignments:
   - Click **Add assignments**
   - Select **Eligible** or **Active** assignment
   - Choose appropriate users/groups
   - Set **Assignment type** and **Duration**
   - **Save**

## Learn more

- [AI administrative roles](https://learn.microsoft.com/entra/identity/role-based-access-control/permissions-reference#ai-administrator)
- [PIM role assignments](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-add-role-to-user)
- [AI administrative roles have assigned principals](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#ai-administrative-roles-have-assigned-principals)
