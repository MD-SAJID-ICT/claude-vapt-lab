# Authorization to Conduct Security Testing

> Fill in, sign, and keep on file **before** any active testing. Reference its filename in the scope
> register. One letter per engagement (or a standing letter for your own assets, reviewed periodically).
> This template is a starting point, not legal advice — adapt it to your jurisdiction and have it
> reviewed where appropriate.

---

**Date:** ________________

**Engagement ID:** ________________  (e.g. 2026-06-07-acme-web)

## 1. Parties
- **Asset owner / authorizing party:** ____________________________________
  (name, title, organization — must have authority to permit testing of the listed assets)
- **Tester:** ____________________________________
- **Contact during testing (both sides):** ____________________________________

## 2. Authorized targets
The tester is authorized to perform vulnerability assessment and penetration testing against ONLY
the following assets:

| Target | Identifier (host / URL / app / range) | Test depth (passive / active / exploit) |
|--------|---------------------------------------|------------------------------------------|
|        |                                       |                                          |
|        |                                       |                                          |

Explicitly **excluded:** all assets not listed above, including any third-party, customer, or
production systems discovered during testing.

## 3. Testing window
- **Start:** ____________  **End:** ____________
- Permitted hours: ____________

## 4. Rules
- Non-destructive proof-of-concept only; no data exfiltration beyond minimal proof; no DoS.
- Use designated test accounts/tenants; no access to real customer data.
- Stop and notify the contact immediately on discovery of: a critical exploitable issue, evidence of
  a prior breach, or exposure of real third-party/customer data.
- Tooling will be rate-limited to avoid service impact.
- Findings and captured secrets are confidential; secrets are reported (redacted) with a rotation
  recommendation, and the tester retains no live credentials after the engagement.

## 5. Liability & acknowledgement
The authorizing party confirms they own or have authority to permit testing of the listed assets and
accepts that authorized testing carries inherent risk. The tester agrees to act within this scope and
applicable law.

**Authorizing party signature:** ____________________  **Date:** __________

**Tester signature:** ____________________  **Date:** __________
