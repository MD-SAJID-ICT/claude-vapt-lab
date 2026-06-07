---
description: Desktop client testing — Electron and native thick clients on Windows & Linux
argument-hint: <path to installer / executable / app bundle>
allowed-tools: Bash, Read, Write, Grep, Glob
---

# Desktop client test — $ARGUMENTS

Local static analysis is safe anytime the artifact is authorized. Dynamic/RCE PoCs run only inside
an isolated VM with a clean snapshot, using a benign payload (calc.exe/xcalc/marker file).

## Step 0 — Pin & classify
- Confirm the build is authorized in `scope/scope-register.md`.
- Hash it (`sha256sum`/`Get-FileHash`); record size; keep the original read-only.
- Classify: Electron app, .NET/Java app, or native (PE/ELF/Mach-O).

## Step 1a — If Electron
- Unpack: `7z x <installer> -o extracted`; `npx @electron/asar extract extracted/resources/app.asar app_src`.
- De-minify main/preload/renderer; report each `webPreferences` vs the checklist: `contextIsolation`
  (true), `nodeIntegration` (false), `sandbox` (true), `webSecurity` (true), `enableRemoteModule`
  (false), and whether it loads **remote** content. Note runtime version / EOL status.
- Grep IPC (`ipcMain`, `.handle(`, preload allowlist, `contextBridge`), dangerous sinks
  (`child_process`, `exec`, `eval`, `shell.openExternal`), navigation (`loadURL`, `will-navigate`,
  `setWindowOpenHandler`), protocol/deep-link handlers, and storage (`electron-store`, `encryptionKey`).
- Scanners: `electronegativity -i app_src -o electroneg.csv`, `retire --path app_src`,
  `osv-scanner --lockfile=app_src/package.json`, `gitleaks`, `semgrep --config p/electron app_src`.

## Step 1b — If native / .NET / Java
- Strings, imports, embedded URLs/secrets; identify frameworks and versions.
- DLL/library search-order & writable-path planting candidates; file/dir ACLs on the install dir.
- Secrets at rest (config/registry/keychain); plaintext credentials/tokens.
- IPC / named pipes / local listeners; privilege boundaries; auto-update integrity.

## Step 2 — Cross-cutting (both)
- Code signing: `signtool verify /pa /v` (Windows) or check the signature/notarization; report if unsigned.
- Data at rest: locate token/credential storage; is it OS-protected (DPAPI/Keychain/safeStorage) or plaintext?
- Auto-update: HTTPS feed? signature/hash verified before applying? (supply-chain risk).
- Custom protocol handlers / deep links: registration + input validation.

## Step 3 — Output
`engagements/<date>-<target>/notes.md`: each issue with file:line/host evidence, severity, CVSS
vector, remediation. The renderer/host RCE PoC is dynamic — VM + snapshot + benign payload only.
