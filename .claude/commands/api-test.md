---
description: OWASP API Security Top 10 testing against an in-scope API (own/test tenant only)
argument-hint: <base URL or path to OpenAPI/Swagger spec>
allowed-tools: Bash, Read, Write, Grep, Glob
---

# API security test — $ARGUMENTS

## Step 0 — Scope gate
`cat scope/scope-register.md`; confirm the API host is `AUTHORIZED`. Use **test accounts you own**.
State the target + the two identities (User A / User B) you will use for authorization tests.

## Step 1 — Load the surface
If given a spec, parse it: list endpoints, methods, declared security schemes, object-addressed
routes (`/{id}`), and any endpoint with NO declared auth. Flag the unauthenticated/object-addressed ones first.

## Step 2 — Work the OWASP API Top 10 (capture every request in the proxy/Repeater)
- **API1 BOLA/IDOR:** with your own token, swap object IDs you don't own. Use Autorize with User B's
  token. One foreign object = proof, then stop.
- **API2 Broken auth:** login lockout, OTP brute/lockout, token reuse after logout, MFA-skip
  acceptance. Throttle; own challenge only.
- **API3 BOPLA / mass assignment:** inject privileged fields (`role`, `is_admin`, `permission`,
  `isModerator`); inspect responses for over-exposed PII/flags.
- **API4 Resource consumption:** rate-limit on resend/login/refresh; unbounded page sizes.
- **API5 BFLA:** replay admin/privileged endpoints with a normal-user token; verb tampering.
- **API7 SSRF / API8 misconfig / API9 inventory / API10 unsafe consumption:** as applicable.
- **JWT:** decode; test alg:none, RS↔HS confusion, weak-secret crack OFFLINE (`hashcat -m 16500/16502`)
  against **your own** token; tamper claims and replay. Report capability, never a forged prod token.
- **Transport:** HTTPS/HSTS, cookie flags, CORS reflection, secrets-in-URL.

## Step 3 — Output
`engagements/<date>-<target>/notes.md`: per finding, request/response diff (redacted), severity,
CVSS vector, OWASP API category, remediation.
