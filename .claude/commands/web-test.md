---
description: OWASP WSTG-driven web application test against an in-scope URL
argument-hint: <target URL>
allowed-tools: Bash, Read, Write, Grep, Glob
---

# Web app test — $ARGUMENTS

## Step 0 — Scope gate
`cat scope/scope-register.md`; confirm `$ARGUMENTS` is `AUTHORIZED`. Use own/test accounts only.

## Step 1 — Map (WSTG: Information Gathering / Configuration)
Crawl with the proxy; fingerprint stack, headers, cookies; enumerate content (throttled); record
security headers (CSP, HSTS, X-Frame-Options) and any missing/weakened.

## Step 2 — Test (WSTG categories)
- **Auth & session:** login, lockout, password reset, fixation, cookie flags (HttpOnly/Secure/
  SameSite), logout invalidation, token storage in the page (`document.cookie`, localStorage).
- **Authorization:** vertical/horizontal privilege escalation, IDOR.
- **Input validation:** XSS (reflected/stored/DOM), SQLi/NoSQLi, SSRF, template/command injection,
  open redirect, deserialization.
- **Business logic:** workflow bypass, race conditions, price/quantity tampering.
- **Client-side:** CORS, postMessage, CSP bypass, third-party script exposure.
- NOTE: if the app is also rendered inside a desktop wrapper (e.g. Electron), flag any XSS as a
  potential RCE chain.

## Step 3 — Output
`engagements/<date>-<target>/notes.md`: per finding with PoC, WSTG id, severity, CVSS, remediation.
Run automated scanners in audit-selected mode on confirmed-safe endpoints; throttle everything.
