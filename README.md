# claude-vapt-lab

> A portable, **Claude-driven** vulnerability-assessment & penetration-testing (VAPT) workspace for
> web, API, mobile, desktop (Electron + native, Windows & Linux), and infrastructure testing —
> designed to run across a coordinated **Kali + Windows** lab and driven by Claude Code, Cowork, and
> Claude.ai.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Authorized use only](https://img.shields.io/badge/use-authorized%20testing%20only-red.svg)](DISCLAIMER.md)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

It turns Claude Code into a methodology-aware testing assistant: a shared **engagement memory**
(`CLAUDE.md`) with hard safety rules, reusable **slash commands** for each testing domain, a
**scope gate** that refuses anything you haven't authorized, cross-platform **setup scripts**, and a
**reporting** workflow — so your process is consistent, auditable, and safe to share with a team.

> ⚠️ **Authorized testing only.** Use exclusively against systems you own or have explicit written
> permission to test, plus intentionally vulnerable practice ranges. Read [`DISCLAIMER.md`](DISCLAIMER.md).

## Why

Pentesters repeat the same setup, methodology prompts, and reporting scaffolding on every engagement.
This kit standardises that into version-controlled, reviewable files an AI agent can follow — with
guardrails so the agent never strays outside an authorized scope.

## Features

- **Safety-first by design** — 10 non-negotiable rules + a scope register the agent checks before
  every active step. Out-of-scope target → it stops and asks.
- **Domain slash commands** — `/recon`, `/web-test`, `/api-test`, `/mobile-test`, `/desktop-test`,
  `/infra-scan`, `/report`, each mapped to OWASP WSTG / API Top 10 / MASVS and CVSS 3.1.
- **Two-host lab** — Kali (attacker) + Windows (target/analysis), with isolation, snapshots, and
  proxy topology documented.
- **One-command setup** — idempotent `kali-setup.sh` / `windows-setup.ps1`, a `bootstrap` for
  clone-or-pull + install, and tool verifiers.
- **Repeatable reporting** — per-engagement folders and a report assembler.

## Quick start

```bash
git clone <your-fork-url> claude-vapt-lab && cd claude-vapt-lab
bash setup/kali-setup.sh          # Linux toolchain (Windows: setup/windows-setup.ps1, elevated)
bash setup/verify-tools.sh
claude                            # launch Claude Code inside the repo
```

Type `/` to see the commands. Start against a practice range:

```
/recon http://10.66.0.10:3000
/web-test http://10.66.0.10:3000
```

Full walkthrough: [`docs/getting-started.md`](docs/getting-started.md).

## Layout

```
claude-vapt-lab/
├── CLAUDE.md                  # engagement memory + hard safety rules (Claude Code reads this)
├── .claude/commands/          # /recon /web-test /api-test /mobile-test /desktop-test /infra-scan /report
├── setup/                     # kali-setup.sh · windows-setup.ps1 · bootstrap.{sh,ps1} · verify-tools.*
├── docs/                      # getting-started · lab-architecture · methodology
├── scope/                     # scope-register · authorization-letter-template · rules-of-engagement
└── engagements/_template/     # per-job: scope.md · notes.md · evidence/ · report/
```

## How Claude products fit

- **Claude Code** — the hands-on driver in each VM; reads `CLAUDE.md`, honours the scope gate, runs commands.
- **Cowork** — desk work: reading specs/binaries, building report docs, organising evidence, tracking the job.
- **Claude.ai** — quick research, CVE lookups, methodology questions on the go.

## Contributing

Issues and PRs welcome — new commands, methodology improvements, tooling, range integrations. See
[`CONTRIBUTING.md`](CONTRIBUTING.md) and the [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md). Please keep
everything **vendor-neutral** and within the authorized-use ethos.

## License

[MIT](LICENSE). Not affiliated with or endorsed by Anthropic.
