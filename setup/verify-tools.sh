#!/usr/bin/env bash
# VAPT Lab — verify Kali toolchain. Run: bash verify-tools.sh
GREEN='\033[1;32m'; RED='\033[1;31m'; NC='\033[0m'
check(){ if command -v "$1" >/dev/null 2>&1; then printf "${GREEN}[+]${NC} %-16s %s\n" "$1" "$($1 --version 2>/dev/null | head -n1)"; else printf "${RED}[-]${NC} %-16s MISSING\n" "$1"; fi; }

echo "== Recon / infra =="
for t in nmap masscan ffuf gobuster httpx nuclei subfinder whatweb nikto; do check "$t"; done
echo "== Web / API =="
for t in mitmproxy sqlmap hydra jwt_tool hashcat john; do check "$t"; done
echo "== Electron / static =="
for t in node npm asar electronegativity retire osv-scanner semgrep gitleaks trufflehog js-beautify 7z; do check "$t"; done
echo "== Mobile =="
for t in apktool jadx adb frida objection; do check "$t"; done
echo "== Capture / misc =="
for t in tshark responder docker; do check "$t"; done
echo "== Claude Code =="
check claude
