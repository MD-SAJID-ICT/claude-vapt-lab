# Lab Architecture & Operations

How the lab is wired, how the hosts cooperate, and the controls that keep testing contained. Read
alongside `../CLAUDE.md` (rules) and `../scope/` (what may be tested).

---

## 1. Topology

```
                          ┌─────────────────────────────────────────────┐
                          │            HOST WORKSTATION (you)            │
                          │   hypervisor: VirtualBox / VMware / Hyper-V  │
                          └───────────────┬──────────────┬──────────────┘
                                          │              │
              ┌───────────────────────────┴──┐      ┌────┴───────────────────────────┐
              │  KALI / LINUX VM (attacker)   │      │  WINDOWS VM (target/analysis)   │
              │  - Claude Code (offense)      │      │  - Claude Code (client analysis)│
              │  - Burp, mitmproxy, nmap...   │      │  - SUT installed here           │
              │  - Docker practice ranges     │      │  - Procmon, signtool, DevTools  │
              │  NICs: NAT + host-only(lab)   │      │  NICs: NAT(optional)+ host-only │
              └───────────────┬───────────────┘      └────────────────┬────────────────┘
                              │                                        │
                              └──────────────  LAB NET  ───────────────┘
                                 host-only / internal network: 10.66.0.0/24
                                 (Kali 10.66.0.10  ·  Win 10.66.0.20)
```

Two NICs per VM:

- **NAT adapter** — controlled outbound internet for updates, installs, and reaching external
  *authorized* targets (e.g. HTB/TryHackMe, your own cloud assets). Detach it for fully air-gapped
  work on local ranges.
- **Host-only / internal "LAB NET"** — isolated `10.66.0.0/24` the VMs share. No inbound from the
  internet. This is where you proxy a desktop client through Burp and host local victim VMs.

Keep the host workstation **out of the test path** — targets and tooling live in VMs.

> Single machine? You can run everything on one Linux box. Still snapshot before destructive tests,
> and still gate every target through `scope/scope-register.md`.

---

## 2. Roles & duties split

| Activity | Runs on | Why |
|----------|---------|-----|
| Recon, web/API testing, proxying, JWT/hashcat, infra scans, mobile (emulator + MobSF), practice ranges | **Kali/Linux** | Native offensive toolchain |
| Installer/bundle unpacking, dependency & secret scans, Electronegativity | Either | Static, OS-agnostic |
| Native/Electron **Windows** client dynamic tests; signature checks; Procmon; DevTools PoC | **Windows VM** | Needs the real Windows runtime |
| Linux desktop (ELF) dynamic tests | **Linux VM** | Native runtime |

### Proxying a desktop client through the proxy
1. Run Burp/mitmproxy on the Linux box, listener bound to the LAB NET IP (e.g. `10.66.0.10:8080`), locked to the lab subnet.
2. Trust the proxy CA in the target VM's OS root store.
3. Point the target VM's system proxy at the listener.
4. For Electron's **main-process** HTTP (Node's `https`, which ignores the OS proxy), launch with
   `HTTPS_PROXY=http://10.66.0.10:8080` and `NODE_EXTRA_CA_CERTS=<ca.pem>` — otherwise you miss
   main-process auth/token traffic.

---

## 3. Snapshot & revert discipline

Per VM, keep named snapshots and revert between destructive tests:

- `clean` — fresh, patched OS, no target.
- `baseline-tooled` — after running the setup script.
- `target-installed` — SUT installed, pre-test.
- Ad-hoc snapshot before any test that changes state (update tamper, file plant, at-rest copy);
  revert to `target-installed` afterwards.

Rule of thumb: if a test writes to disk or changes config — snapshot first.

---

## 4. Practice ranges

Run on the Linux box's Docker, bound to LAB NET only. Use them to validate tooling and rehearse
technique. They are pre-authorized in the scope register.

```bash
# OWASP Juice Shop  ->  http://10.66.0.10:3000
docker run -d --name juiceshop -p 10.66.0.10:3000:3000 bkimminich/juice-shop

# DVWA              ->  http://10.66.0.10:8081  (admin/password; set level in UI)
docker run -d --name dvwa -p 10.66.0.10:8081:80 vulnerables/web-dvwa

# WebGoat           ->  http://10.66.0.10:8082/WebGoat
docker run -d --name webgoat -p 10.66.0.10:8082:8080 webgoat/webgoat

# MobSF (mobile static/dynamic) -> http://10.66.0.10:8000
docker run -d --name mobsf -p 10.66.0.10:8000:8000 opensecurity/mobile-security-framework-mobsf:latest
```

- **VulnHub** VMs: import onto LAB NET (host-only), no NAT, attack from Kali.
- **HTB / TryHackMe**: connect via their VPN on the NAT adapter and obey *their* rules of engagement.
  Add the active target to the scope register for its duration only.

---

## 5. Where Claude Code, Cowork, and Claude.ai fit

- **Claude Code (each VM)** — the hands-on driver. It reads `CLAUDE.md`, honours the scope gate, and
  runs the slash commands. Launch from inside the repo (`cd claude-vapt-lab && claude`).
- **Cowork** — desk work around testing: reading specs/binaries, building report `.docx`/`.xlsx`,
  organising evidence, drafting remediation tickets, tracking the engagement.
- **Claude.ai (web/mobile)** — quick research, CVE lookups, methodology questions on the go.

Keep the repo in sync across hosts (git is simplest). `.gitignore` keeps evidence/secrets out.

---

## 6. Data handling

- Captured tokens/cookies/hashes/keys are **live secrets**: analyse, then recommend rotation.
- Never copy real user/customer data out of a target. For IDOR/BOLA, one foreign object is the
  proof — capture that single response (redacted) and stop.
- Wipe loot and revert snapshots at engagement close.
