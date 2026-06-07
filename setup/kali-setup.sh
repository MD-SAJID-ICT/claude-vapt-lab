#!/usr/bin/env bash
# =============================================================================
# VAPT Lab — Kali Linux toolchain setup (idempotent)
# Run as a normal user with sudo available:  bash kali-setup.sh
# Safe to re-run; it skips anything already installed.
# =============================================================================
set -uo pipefail

log()  { printf '\033[1;34m[*]\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32m[+]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[!]\033[0m %s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

if [[ "$(id -u)" -eq 0 ]]; then
  warn "Run as a normal user (sudo is used where needed), not as root."
fi

# ---------------------------------------------------------------------------
log "Updating apt and installing base + offensive tooling"
sudo apt-get update -y
APT_PKGS=(
  git curl wget jq unzip p7zip-full build-essential ca-certificates
  python3 python3-pip python3-venv pipx
  nodejs npm golang-go openjdk-17-jdk-headless
  nmap masscan whatweb nikto sqlmap hydra wfuzz gobuster ffuf
  hashcat john dirb seclists wordlists
  mitmproxy wireshark tshark
  apktool jadx adb scrcpy
  responder
  docker.io docker-compose
)
sudo apt-get install -y "${APT_PKGS[@]}" || warn "Some apt packages may be unavailable on this image; continuing."
pipx ensurepath >/dev/null 2>&1 || true

# Burp Suite (community ships on Kali as 'burpsuite'); install if missing
have burpsuite || sudo apt-get install -y burpsuite || warn "Install Burp Suite Pro manually for the licensed extensions."

# ---------------------------------------------------------------------------
log "Python tooling via pipx (isolated)"
PIPX_PKGS=( jwt_tool semgrep trufflehog objection frida-tools impacket )
for p in "${PIPX_PKGS[@]}"; do
  pipx list 2>/dev/null | grep -qi "$p" || pipx install "$p" || warn "pipx install $p failed"
done

# ---------------------------------------------------------------------------
log "Node global tooling (Electron static analysis)"
NPM_PKGS=( @electron/asar @doyensec/electronegativity retire js-beautify )
for p in "${NPM_PKGS[@]}"; do
  npm ls -g "$p" >/dev/null 2>&1 || sudo npm install -g "$p" || warn "npm -g $p failed"
done

# ---------------------------------------------------------------------------
log "Go tooling (recon)"
export PATH="$PATH:$(go env GOPATH 2>/dev/null)/bin"
go_install() { have "$1" || go install "$2" || warn "go install $2 failed"; }
go_install httpx     github.com/projectdiscovery/httpx/cmd/httpx@latest
go_install nuclei    github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go_install subfinder github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go_install osv-scanner github.com/google/osv-scanner/cmd/osv-scanner@latest
have nuclei && nuclei -update-templates >/dev/null 2>&1 || true

# ---------------------------------------------------------------------------
log "gitleaks"
have gitleaks || { GLV=$(curl -s https://api.github.com/repos/gitleaks/gitleaks/releases/latest | jq -r .tag_name);
  curl -sL "https://github.com/gitleaks/gitleaks/releases/download/${GLV}/gitleaks_${GLV#v}_linux_x64.tar.gz" -o /tmp/gl.tgz \
  && sudo tar -xzf /tmp/gl.tgz -C /usr/local/bin gitleaks || warn "gitleaks install failed"; }

# ---------------------------------------------------------------------------
log "Docker group + MobSF + practice-range images (pulled, not started)"
sudo systemctl enable --now docker 2>/dev/null || true
sudo usermod -aG docker "$USER" 2>/dev/null || true
docker pull opensecurity/mobile-security-framework-mobsf:latest 2>/dev/null || warn "MobSF pull skipped"
docker pull vulnerables/web-dvwa:latest 2>/dev/null || true
docker pull bkimminich/juice-shop:latest 2>/dev/null || true
docker pull webgoat/webgoat:latest 2>/dev/null || true

# ---------------------------------------------------------------------------
log "Claude Code (if Node present and not installed)"
have claude || { have npm && sudo npm install -g @anthropic-ai/claude-code 2>/dev/null || warn "Install Claude Code manually if needed"; }

ok "Kali setup complete. Run ./verify-tools.sh to confirm. Log out/in once for the docker group to apply."
echo "Practice ranges: see docs/lab-architecture.md §Practice ranges for compose commands."
