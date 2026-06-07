---
description: Authorized network/service enumeration of in-scope infrastructure
argument-hint: <CIDR or host you are authorized to scan>
allowed-tools: Bash, Read, Write, Grep, Glob
---

# Infra scan — $ARGUMENTS

## Step 0 — Scope gate (strict)
`cat scope/scope-register.md`. Scan ONLY hosts/ranges with an `AUTHORIZED` row. A public/cloud IP may
be provider-owned — confirm you own the *asset*, not just the address. If unsure, STOP and ask.

## Step 1 — Discovery (throttled)
- Host discovery: `nmap -sn <cidr>` (or masscan at a low rate on a large range you own).
- Service/version: `nmap -sV -sC -T3 -p- <host>` per live host; save `-oA` output to evidence.

## Step 2 — Assess
- `nuclei` (rate-limited) against discovered web services (authorized only).
- TLS posture (`testssl.sh`/`sslscan`), exposed admin panels, default creds (practice/lab only),
  known-CVE services (map versions → CVEs and cite them).

## Step 3 — Output
`engagements/<date>-<target>/notes.md`: host/port/service table, exposures, version→CVE map,
severity + CVSS, remediation. No exploitation beyond safe version/PoC confirmation; nothing destructive.
