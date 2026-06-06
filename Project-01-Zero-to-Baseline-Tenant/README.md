# Project 01 — Zero-to-Baseline Tenant (Identity Foundation)

## Objective

Build a real organisation's identity layer from an empty Microsoft Entra tenant — administrative boundaries, delegated administration, security groups, bulk-provisioned users, and managed attributes — entirely through Microsoft Graph PowerShell, so the whole baseline is repeatable.

**Why this matters:** This is the foundation every other identity control sits on. Groups drive access assignment, attributes drive dynamic membership and policy targeting, administrative units enable scoped delegation, and automation proves you can operate at enterprise scale. It maps directly to the SC-300 domain *Implement and manage user identities (20–25%)*.

---

## Environment

| Item | Value |
|------|-------|
| Tenant | `iam-lab` |
| Identity platform | Microsoft Entra ID |
| Licence (at build time) | Microsoft Entra ID **Free** |
| Automation | Microsoft Graph PowerShell SDK |
| Project type | Identity foundation |

> See the root README's **Lab Licensing** note. Some objectives below (dynamic groups, custom roles) require **Entra ID P1/P2** — activate the 30-day P2 trial to complete them.

---

## What Was Built & Why

### Administrative Units
| AU | Scope |
|----|-------|
| `AU-Hyderabad` | Hyderabad office users |
| `AU-Bangalore` | Bangalore office users |
| `AU-Pune` | Pune office users |

**Why:** Administrative Units create scoped administrative boundaries. They let you delegate control over a slice of the directory (e.g. one office) without handing out tenant-wide roles — the practical expression of least privilege.

### Delegated Administration
A delegated admin account (**Hyd HR Admin**) was scoped to `AU-Hyderabad`.

**Why:** Demonstrates scoped role assignment — the admin can manage users *within Hyderabad only*. This is how large orgs let regional/HR teams self-manage without becoming security risks.

### Security Groups
`GRP-IT-Admins`, `GRP-HR-Team`, `GRP-Sales-Team`, `GRP-Finance-Team`, `GRP-Marketing-Team`

**Why:** Groups centralise permission management. Assigning access to a group instead of individuals is the basis of RBAC and makes every later access decision (app assignment, Conditional Access targeting, access packages) cleaner and auditable.

### Bulk User Provisioning
~90 user accounts provisioned via Graph PowerShell, with realistic identities generated from **randomuser.me** (sourced through the [public-apis directory](https://github.com/public-apis/public-apis)).

**Why:** Real tenants aren't built one user at a time. Scripted bulk provisioning demonstrates enterprise-scale automation and gives the tenant enough population to make groups, dynamic rules, and reporting meaningful.

### User Attribute Management
Populated `Department`, `City`, and `Job Title` on provisioned users (e.g. Department = IT, City = Hyderabad, Job Title = System Administrator).

**Why:** Attributes are the fuel for dynamic group membership, Conditional Access targeting, and governance policies later in the track. A baseline with rich attributes is what makes those features demonstrable.

### Role Management (RBAC review)
Enumerated built-in directory roles (Global Administrator, User Administrator, Helpdesk Administrator, Directory Readers, Exchange Administrator, etc.) via Graph PowerShell.

**Why:** Understanding the built-in least-privilege roles is prerequisite to choosing the *right* role for delegation rather than over-granting Global Admin — a core SC-300 and security principle.

---

## Scripts

| File | Purpose |
|------|---------|
| `01-Create-AUs.ps1` | Creates the three Administrative Units |
| `02-Create-Groups.ps1` | Creates the five functional security groups |
| `03-Bulk-Create-Users.ps1` | Provisions ~90 users from randomuser.me data |
| `04-Update-UserAttributes.ps1` | Sets Department / City / Job Title on users |
| `05-Delegated-Admin.ps1` | Creates the delegated admin and scopes it to AU-Hyderabad |

---

## Documented Limitations & Remediation

These walls were hit on the **Entra ID Free** licence, tested, and documented — the troubleshooting itself is part of the work.

| Limitation | Cause | Remediation |
|------------|-------|-------------|
| Dynamic group rule (`user.city -eq "Hyderabad"`) failed with `NoLicenseForOperation` | Dynamic groups require **Entra ID P1** | Activate the 30-day **Entra ID P2 trial**, then re-run the dynamic rule |
| Custom roles unavailable | Custom directory roles require **Entra ID P1** | Same — available under the P2 trial |
| `Get-MgSubscribedSku` returned no assignable SKUs | No licences provisioned in a bare Free tenant | The P2 trial adds an assignable SKU; licence-assignment testing can then be completed |

**Action for re-run:** after enabling the P2 trial, re-execute the dynamic-group step and add a custom least-privilege role to fully close out the domain.

---

## Screenshots Required

Save these to `Screenshots/`:

1. **`01-admin-units.png`** — Entra admin center → **Administrative units** list showing AU-Hyderabad / AU-Bangalore / AU-Pune.
2. **`02-au-delegation.png`** — `AU-Hyderabad` → **Roles and administrators**, showing *Hyd HR Admin* scoped to the AU.
3. **`03-groups.png`** — **Groups** list showing the five `GRP-*` groups.
4. **`04-users-list.png`** — **Users** list showing the ~90 provisioned accounts (with a visible count).
5. **`05-user-attributes.png`** — a single user's profile showing populated Department / City / Job Title.
6. **`06-bulk-script-run.png`** — terminal showing `03-Bulk-Create-Users.ps1` executing and the created-user count.
7. **`07-dynamic-group-error.png`** — the `NoLicenseForOperation` failure (evidence of the documented limitation).
8. **`08-subscribed-sku.png`** — `Get-MgSubscribedSku` output showing no assignable SKUs (the licensing finding).
9. *(after P2 trial)* **`09-dynamic-group-success.png`** — the dynamic group populating correctly once licensed.

---

## Skills Demonstrated

Microsoft Entra ID administration · Microsoft Graph PowerShell · Administrative Units · delegated/scoped administration · identity automation · user lifecycle management · security group management · RBAC review · troubleshooting and licensing analysis.

---

## Done When

You have a scripted, re-runnable tenant baseline and can explain the reasoning behind every AU, group, and role choice without notes.

---

## Status

✅ **Complete** (on Free licence) — dynamic groups and custom roles pending re-run under the Entra ID P2 trial.
