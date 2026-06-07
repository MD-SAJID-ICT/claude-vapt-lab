# Contributing to claude-vapt-lab

Thanks for helping improve the kit! Contributions that make VAPT work more consistent, safer, and
more useful to the community are very welcome.

## Ground rules
- **Vendor-neutral.** No client-, employer-, or product-specific content (no real hostnames, tokens,
  customer names, internal endpoints). Keep examples generic (`example.com`, lab IPs).
- **Authorized-use ethos.** Nothing that facilitates unauthorized access. PoCs stay benign and
  non-destructive. No malware, no weaponised exploits, no real secrets.
- **No secrets in commits.** Never commit tokens, keys, captures, or evidence. Respect `.gitignore`.

## What to contribute
- New or improved **slash commands** (`.claude/commands/*.md`).
- **Methodology** updates aligned to OWASP WSTG / API Top 10 / MASVS / PTES.
- **Tooling** additions to the setup scripts (keep them idempotent and cross-distro where possible).
- **Practice-range** integrations and lab-architecture improvements.
- Docs, fixes, and clearer safety guidance.

## How to submit
1. Fork and create a branch: `feat/<short-name>` or `fix/<short-name>`.
2. Keep changes focused; update relevant docs.
3. Test what you can:
   - Shell: `bash -n setup/*.sh` (syntax) and a dry run where practical.
   - Commands: confirm the frontmatter parses and the scope-gate step is present.
4. Open a PR using the template. Describe the change, the rationale, and any testing done.

## Style
- Slash commands: YAML frontmatter (`description`, `argument-hint`, `allowed-tools`) + a Step 0 scope
  gate + clear output location.
- Markdown: wrap around ~100 cols; prefer tables for checklists.
- Shell: `set -uo pipefail`, idempotent, helpful logging.

## Reporting security issues with the kit itself
See [`SECURITY.md`](SECURITY.md). Please do not open public issues for sensitive reports.

By contributing, you agree your contributions are licensed under the project's [MIT License](LICENSE).
