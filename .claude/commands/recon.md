---
description: Passive + light-active reconnaissance and attack-surface mapping for an in-scope target
argument-hint: <target host/domain/app>
allowed-tools: Bash, Read, Write, Grep, Glob, WebSearch, WebFetch
---

# Recon — $ARGUMENTS

Map the attack surface of **$ARGUMENTS**.

## Step 0 — Scope gate (mandatory)
1. `cat scope/scope-register.md`; confirm `$ARGUMENTS` matches an `AUTHORIZED` row in its window.
2. If not present, STOP and report it is out of scope. Run no active step.
3. State in one line: target, and whether passive-only or active-allowed per the register.

## Step 1 — Passive (always safe)
- WHOIS, DNS, certificate transparency (crt.sh), public OSINT, tech-stack fingerprinting.
- Record discovered hosts/subdomains — but do NOT probe ones outside scope.

## Step 2 — Light active (only if the register marks active testing AUTHORIZED)
- Throttled service discovery: `nmap -sV -T3 --top-ports 1000 <host>`.
- Live web hosts: `httpx`; fingerprints: `whatweb`.
- Content discovery: `ffuf`/`gobuster` with a sane wordlist and capped rate.

## Step 3 — Output
Write to `engagements/<date>-<target>/notes.md`: surface map (hosts/ports/services/versions), tech
stack, third-party integrations, and ranked candidate test areas (each tagged with its methodology
section). Flag anything out-of-scope or third-party — don't touch it. Recon only; no exploitation.
