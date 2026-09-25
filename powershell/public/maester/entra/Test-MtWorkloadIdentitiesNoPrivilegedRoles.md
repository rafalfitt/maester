# Workload identities should not be assigned privileged roles

Workload identities (service principals, managed identities) should not be assigned privileged directory roles.

## How to fix

Remove privileged role assignments from workload identities:

1. Go to **Entra ID** → **Privileged Identity Management** → **Roles**
2. For each privileged role, check **Assignments**
3. Find workload identities (service principals, managed identities) with assignments
4. **Remove** these assignments
5. If workload identities need elevated permissions, use **PIM eligible assignments** with approval

## Learn more

- [Workload identities](https://learn.microsoft.com/entra/workload-id/workload-identities-overview)
- [PIM for workload identities](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-how-to-add-role-to-user#make-a-user-eligible-for-a-role)
- [Workload identities are not assigned privileged roles](https://learn.microsoft.com/en-us/entra/fundamentals/configure-security#workload-identities-are-not-assigned-privileged-roles)
