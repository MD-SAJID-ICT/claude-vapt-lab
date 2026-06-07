# Methodology

Per-domain checklists the slash commands follow. Map every finding to a standard and score it with
CVSS 3.1 (record the vector string, not just the number).

## Standards
- **Web:** OWASP Web Security Testing Guide (WSTG)
- **API:** OWASP API Security Top 10 (2023)
- **Mobile:** OWASP MASVS / MASTG
- **Process:** PTES (Penetration Testing Execution Standard)
- **Scoring:** CVSS 3.1

---

## Web (WSTG)
Information gathering · configuration & deployment · identity management · authentication ·
authorization · session management · input validation (XSS, SQLi/NoSQLi, SSRF, injection, open
redirect, deserialization) · error handling · cryptography · business logic · client-side.

## API (OWASP API Top 10 2023)
1. BOLA (object-level authz) · 2. Broken authentication · 3. BOPLA (property-level authz /
mass assignment) · 4. Unrestricted resource consumption · 5. BFLA (function-level authz) ·
6. Unrestricted access to sensitive business flows · 7. SSRF · 8. Security misconfiguration ·
9. Improper inventory management · 10. Unsafe consumption of APIs.

## Mobile (MASVS)
Storage · cryptography · authentication & session · network communication · platform interaction
(IPC, deep links, exported components, WebViews) · code quality · resilience (anti-tamper, root/
jailbreak, pinning).

## Desktop / thick client
- **Electron:** webPreferences hardening (contextIsolation, sandbox, nodeIntegration off,
  webSecurity, remote module), IPC/preload surface, navigation allowlist, protocol handlers,
  secrets at rest, runtime EOL, auto-update integrity.
- **Native (PE/ELF/Mach-O), .NET, Java:** library search-order/planting, file/dir ACLs, secrets at
  rest, local IPC/pipes/listeners, privilege boundaries, code signing, update integrity.

## Network / infrastructure
Service enumeration · version→CVE mapping · TLS posture · exposed management interfaces · default
credentials (lab only) · misconfigurations · segmentation.

---

## CVSS 3.1 quick reference
Vector form: `CVSS:3.1/AV:_/AC:_/PR:_/UI:_/S:_/C:_/I:_/A:_`
- AV Attack Vector: N(etwork)/A(djacent)/L(ocal)/P(hysical)
- AC Attack Complexity: L/H · PR Privileges: N/L/H · UI User Interaction: N/R
- S Scope: U(nchanged)/C(hanged) · C/I/A Impact: N/L/H
Use the [FIRST CVSS calculator](https://www.first.org/cvss/calculator/3.1) and paste the vector into
each finding.

## Severity bands (guideline)
Critical 9.0–10.0 · High 7.0–8.9 · Medium 4.0–6.9 · Low 0.1–3.9 · Informational 0.0.
