---
description: OWASP MASVS/MASTG static + dynamic test of an in-scope mobile app (Android/iOS)
argument-hint: <path to .apk or .ipa>
allowed-tools: Bash, Read, Write, Grep, Glob
---

# Mobile app test — $ARGUMENTS

## Step 0 — Scope gate
Confirm the app is an own-asset/authorized in `scope/scope-register.md`. Test on an emulator/own device.

## Step 1 — Static (MASTG)
- Android: `apktool d $ARGUMENTS -o app_src`; `jadx -d jadx_out $ARGUMENTS`. Review manifest:
  exported components, `debuggable`, `allowBackup`, custom permissions, deep-link `intent-filter`
  schemes, cleartext/network-security-config.
- iOS: unzip the `.ipa`, inspect `Info.plist`, ATS exceptions, URL schemes, entitlements, embedded frameworks.
- Secrets: `gitleaks`/`trufflehog`/grep over decompiled source for keys, endpoints, hardcoded creds.
- Automated baseline: run through MobSF (Docker).

## Step 2 — Dynamic
- Proxy through the intercepting proxy (install user CA / adjust network-security-config in a test build).
- Cert pinning: detect; bypass with Frida/objection on **your own** build to observe traffic.
- Storage: inspect app sandbox for plaintext tokens, prefs/plists, SQLite, logs.
- IPC/deep links: fire exported-component intents / custom URL schemes and observe handling.
- API: feed captured traffic into the `/api-test` flow against the authorized test tenant.

## Step 3 — Output
`engagements/<date>-<target>/notes.md`: findings mapped to MASVS controls, severity, CVSS, remediation.
