# SC-300 Entra ID Labs

A hands-on lab portfolio for the **Microsoft Identity and Access Administrator (SC-300)** certification. Every project here is built from scratch in a live Microsoft Entra tenant and automated with the Microsoft Graph PowerShell SDK — the goal is applied skill and demonstrable proof, not exam recall.

Each project maps to one or more SC-300 objective domains and ends in a defined "done" condition plus screenshots that evidence the work.

---

## ⚠️ Lab Licensing — Read First

Several projects require **Microsoft Entra ID P1 or P2** features (dynamic groups, custom roles, Conditional Access, Identity Protection, PIM, identity governance). A bare **Entra ID Free** tenant will block these.

**Recommended path:** activate the **30-day Entra ID P2 free trial** in the tenant (Entra admin center → *Billing / Licensing* → *Try / Buy*). This unlocks all premium features at no cost for the trial period.

> The trial is time-boxed (30 days). Group the licence-dependent projects — **Project 2 (Conditional Access)**, **Project 5 (Governance)**, and the risk-detection parts of **Project 6 (Monitoring)** — into that window so the trial isn't wasted on the foundational work.

The free Microsoft 365 Developer Program E5 sandbox is *no longer reliably available* to personal accounts (it now generally requires a Visual Studio Professional/Enterprise subscription), so the P2 trial is the dependable route.

---

## Project Index

| # | Project | SC-300 Domain | Status |
|---|---------|---------------|--------|
| 00 | Lab Foundation | Tooling / environment setup | ✅ Complete |
| 01 | Zero-to-Baseline Tenant | Implement and manage user identities (20–25%) | ✅ Complete |
| 02 | Conditional Access & MFA Hardening | Authentication & access management (25–30%) | ⬜ Planned |
| 03 | Hybrid Identity | Hybrid identity objectives | ⬜ Planned |
| 04 | App Access & SSO | Workload identities (20–25%) | ⬜ Planned |
| 05 | Identity Governance | Plan and automate identity governance (20–25%) | ⬜ Planned |
| 06 | Monitoring & Posture | Monitoring objectives | ⬜ Planned |
| 🏁 | Capstone: Secure Identity Reference Architecture | All domains | ⬜ Planned |

---

## Repository Structure

```
SC300-EntraID-Labs/
├── Project-00-Lab-Foundation/
│   ├── Connect-MgGraph.ps1
│   └── README.md
├── Project-01-Zero-to-Baseline-Tenant/
│   ├── 01-Create-AUs.ps1
│   ├── 02-Create-Groups.ps1
│   ├── 03-Bulk-Create-Users.ps1
│   ├── 04-Update-UserAttributes.ps1
│   ├── 05-Delegated-Admin.ps1
│   ├── Screenshots/
│   └── README.md
└── README.md
```

---

## Tech Stack

- **Identity platform:** Microsoft Entra ID
- **Automation:** Microsoft Graph PowerShell SDK (`Microsoft.Graph`)
- **Monitoring (later projects):** Azure Log Analytics + KQL, Entra Workbooks
- **Test data:** [randomuser.me](https://randomuser.me) — sourced via the [public-apis directory](https://github.com/public-apis/public-apis), the go-to catalog for free public APIs
- **Diagrams:** draw.io

---

## Conventions

- **Screenshots** for each project live in that project's `Screenshots/` folder, named to match the "Screenshots Required" checklist in its README.
- **All data is fictional.** Users, names, and org details are generated test data in a personal lab tenant — no real or production data is used.
- **Scripts are idempotent where possible**, so a build can be re-run cleanly.

---

## Author

Built as a hands-on SC-300 study and portfolio project by an Active Directory / IAM engineer. Each milestone is documented to be re-buildable and interview-demonstrable.
