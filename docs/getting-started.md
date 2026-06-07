# Getting Started

A practical walkthrough from zero to your first authorized test.

## Prerequisites
- Two machines/VMs recommended: a **Kali/Linux** box (attacker) and a **Windows** box (target/
  analysis). One Linux box also works.
- [Claude Code](https://docs.claude.com/en/docs/claude-code) installed and authenticated on each.
- A hypervisor (VirtualBox / VMware / Hyper-V) if you're using VMs.
- Internet access for the first toolchain install.

## 1. Get the repo onto each host

With git (recommended — keeps hosts in sync):

```bash
git clone <your-fork-url> claude-vapt-lab
cd claude-vapt-lab
```

Or use the one-line bootstrap (clone-or-pull + setup):

```bash
# Linux
curl -fsSL <raw-url>/setup/bootstrap.sh | bash -s -- <your-fork-url>
```
```powershell
# Windows (elevated PowerShell)
iwr -useb <raw-url>/setup/bootstrap.ps1 | iex
```

## 2. Install the toolchain

```bash
# Kali / Linux
bash setup/kali-setup.sh
bash setup/verify-tools.sh      # green [+] = present
```
```powershell
# Windows — elevated PowerShell
powershell -ExecutionPolicy Bypass -File .\setup\windows-setup.ps1
```

Both setup scripts are idempotent — re-run to fill gaps. The first run pulls a lot of packages.

## 3. Build the lab network
Follow `docs/lab-architecture.md`: two NICs per VM (NAT + host-only LAB NET `10.66.0.0/24`), and
named snapshots (`clean`, `baseline-tooled`, `target-installed`).

## 4. Authorize a target
1. Fill and sign `scope/authorization-letter-template.md` (own assets or written client permission).
2. Add a row to `scope/scope-register.md` with **Status = AUTHORIZED** and a date window.
   - Practice ranges (DVWA/Juice Shop/WebGoat/HTB/THM) are already authorized.

## 5. Drive it from Claude Code
```bash
cd claude-vapt-lab
claude
```
Type `/` to see the commands. Start safe against a practice range:
```
/recon http://10.66.0.10:3000
/web-test http://10.66.0.10:3000
```
Ask "what's my scope?" — Claude should read the register and refuse anything not `AUTHORIZED`.

## 6. Run a real engagement
```bash
cp -r engagements/_template "engagements/$(date +%F)-<target>"
# edit its scope.md, then:
```
```
/api-test https://api.example.com/openapi.json
/report engagements/2026-06-07-example
```

## Notes
- Slash commands and `CLAUDE.md` load **only** when you launch Claude Code from inside the repo.
- The scope gate is the safety backbone — keep `scope-register.md` honest and current.
