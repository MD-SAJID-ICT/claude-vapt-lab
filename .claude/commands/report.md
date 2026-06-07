---
description: Assemble engagement notes into the standard VAPT report
argument-hint: <engagement folder, e.g. engagements/2026-06-07-acme-web>
allowed-tools: Bash, Read, Write, Grep, Glob
---

# Build report — $ARGUMENTS

Assemble a client-ready report from `$ARGUMENTS/notes.md` and `$ARGUMENTS/evidence/`.

## Structure
1. **Engagement overview** — target, artifacts, dates, authorization reference, artifact hash(es).
2. **Executive summary** — business-readable risk picture; top issues; severity-count table.
3. **Scope, authorization & methodology** — what/how, tool list, standards (WSTG/API Top 10/MASVS/CVSS 3.1).
4. **Findings register** — ID, severity, title (Critical→Low).
5. **Detailed findings** — per finding: description, location, redacted evidence, repro steps,
   impact, CVSS 3.1 vector, remediation.
6. **Positive observations.**
7. **Prioritized remediation roadmap** — Immediate / Short / Medium term.
8. **Appendices** — command log, raw scanner output, environment.

## Rules
- Redact all live tokens/secrets/PII in evidence.
- Every finding needs a CVSS vector and a concrete remediation.
- Output `.docx` (via the docx skill) or `.md` into `$ARGUMENTS/report/`.
- Do not invent findings — only what notes.md + evidence support; mark unconfirmed leads as such.
