# Rules of Engagement (RoE)

Standing operating rules for this lab. A per-engagement authorization letter can tighten these but
never loosen the safety floor below.

## Authorization
- No active testing without a signed authorization letter on file and a matching `AUTHORIZED` row in
  `scope-register.md`.
- Recon beyond passive OSINT counts as active testing.

## Targets
- Test only listed targets. Hosts discovered mid-engagement are out of scope until added to the
  register with authorization.
- Never test third-party / customer / partner systems, or production tenants other than a designated
  test tenant.

## Conduct
- **Non-destructive PoCs:** benign marker file, `calc.exe`/`xcalc`, a single proof response, a hash
  to your own listener. No reverse shells on shared hosts, no destructive calls, no real data theft.
- **One-object rule** for IDOR/BOLA: the first foreign object you can read is the proof — capture
  (redacted) and stop.
- **Throttle** all automated tooling. No volumetric brute force except against local practice ranges.
- **Own accounts/objects** only for auth, session, and object tests.
- **Isolation:** dynamic tests run in lab VMs with snapshots; revert between state-changing tests.

## Secrets & data
- Treat all captured tokens/cookies/hashes/keys as live; analyse, then recommend rotation/revocation.
- Never commit secrets or evidence to git (see `.gitignore`). Redact in every report and screenshot.

## Stop conditions — halt and notify the engagement contact immediately if you:
- Find a critical, actively-exploitable issue.
- See evidence of a pre-existing compromise.
- Encounter real third-party or customer data.
- Cause, or risk causing, a service disruption.

## Reporting
- Every finding: ID, severity, CVSS 3.1 vector, affected component, repro steps, redacted evidence,
  impact, remediation. Note unconfirmed leads as such.
- Deliver via the `/report` command into the engagement's `report/` folder.
