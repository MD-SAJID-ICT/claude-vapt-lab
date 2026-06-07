# Security Policy

## Scope of this policy
This concerns the security of **the `claude-vapt-lab` kit itself** (scripts, commands, docs) — for
example a setup script that could harm a user's machine, or guidance that could weaken the safety
model. It is **not** a channel for findings from your own engagements (those go to the asset owner
you tested, under your authorization).

## Reporting a vulnerability in the kit
- Please report privately first: open a GitHub **security advisory** on the repository, or contact
  the maintainer listed in the repo profile. Avoid public issues for sensitive reports.
- Include: affected file(s), the risk, reproduction steps, and a suggested fix if you have one.
- We aim to acknowledge within a reasonable time and credit reporters who wish to be named.

## Good-faith
We support good-faith research into this project and will not pursue reporters acting in good faith
within this policy.

## Out of scope
- Vulnerabilities in third-party tools the kit installs (report those upstream).
- Issues that require already-compromised hosts or misuse contrary to `DISCLAIMER.md`.
