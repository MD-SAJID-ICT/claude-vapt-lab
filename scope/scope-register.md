# Scope Register

**Single source of truth for what may be tested.** Claude Code checks this file before any active
step. A target is testable only if it has a row here with **Status = AUTHORIZED** and the current
date is within its window. If a target is not listed, it is OUT OF SCOPE — stop and ask.

Status values: `AUTHORIZED` · `PASSIVE-ONLY` · `OUT-OF-SCOPE` · `EXPIRED`

> Replace the example rows below with your own engagements. Keep this file honest — it is the
> safety backbone of the whole kit.

---

## In scope (require authorization letter on file)

| Asset | Identifier(s) | Type | Test depth | Auth ref | Window | Status |
|-------|---------------|------|------------|----------|--------|--------|
| _example web app_ | `https://app.example.com` (test tenant) | Web | Full, test accounts | `2026-01-01-example.pdf` | 2026-01-01 → 2026-01-14 | `OUT-OF-SCOPE` |
| _example API_ | `https://api.example.com` | REST API | Full, test tenant | _fill_ | _fill_ | _set when authorized_ |
| _example desktop_ | `app-installer.exe` (own build) | Desktop | Static + dynamic in VM | _fill_ | _fill_ | _set when authorized_ |
| _example mobile_ | own APK/IPA | Mobile | Static + dynamic (emulator) | _fill_ | _fill_ | _set when authorized_ |
| _example infra_ | hosts/ranges you own | Infra | Per letter | _fill_ | _fill_ | _set when authorized_ |

> Set `Status = AUTHORIZED` only after the letter is signed and on file, and set a date `Window`.
> Use **test tenants/accounts** — not real customer/production data.

## In scope — practice ranges (authorized by their nature)

| Range | Endpoint (LAB NET) | Status |
|-------|--------------------|--------|
| OWASP Juice Shop | http://10.66.0.10:3000 | AUTHORIZED |
| DVWA | http://10.66.0.10:8081 | AUTHORIZED |
| WebGoat | http://10.66.0.10:8082/WebGoat | AUTHORIZED |
| VulnHub VMs (host-only) | as imported | AUTHORIZED |
| Hack The Box / TryHackMe | active machine only, via their VPN | AUTHORIZED while their RoE applies |

## OUT OF SCOPE (default for everything not listed above)

| Asset | Why |
|-------|-----|
| Any host discovered during recon but not listed above | Not authorized |
| Any production tenant other than a designated test tenant | Real user data |
| Any third-party / customer / partner / government system | Not yours to test |
| Cloud IPs you don't own the underlying asset for | Provider-owned address ≠ your asset |

---

### Change log
- _YYYY-MM-DD_ — created. Add a line for every scope change (who/what/when/auth ref).
