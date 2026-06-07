<#
=============================================================================
 VAPT Lab - Windows 11 toolchain setup (idempotent)
 Run from an ELEVATED PowerShell:   powershell -ExecutionPolicy Bypass -File windows-setup.ps1
 Focus: Electron desktop-client analysis + host-level checks. Offensive tooling lives on Kali.
=============================================================================
#>
$ErrorActionPreference = 'Continue'
function Log($m){ Write-Host "[*] $m" -ForegroundColor Cyan }
function Ok($m){ Write-Host "[+] $m" -ForegroundColor Green }
function Warn($m){ Write-Host "[!] $m" -ForegroundColor Yellow }
function Have($c){ return [bool](Get-Command $c -ErrorAction SilentlyContinue) }

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Warn "Not elevated. Re-run this script as Administrator."; exit 1
}

# --- Package manager: prefer winget, fall back to Chocolatey -----------------
$useWinget = Have winget
if (-not $useWinget) {
  Log "winget not found; installing Chocolatey"
  if (-not (Have choco)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  }
}

function Install-Pkg($wingetId, $chocoId) {
  if ($useWinget) {
    winget install --id $wingetId -e --accept-source-agreements --accept-package-agreements --silent 2>$null
  } else {
    choco install $chocoId -y 2>$null
  }
}

# --- Core analysis tools -----------------------------------------------------
Log "Installing desktop-analysis toolchain"
Install-Pkg '7zip.7zip'                 '7zip'
Install-Pkg 'OpenJS.NodeJS.LTS'         'nodejs-lts'
Install-Pkg 'Python.Python.3.12'        'python'
Install-Pkg 'Git.Git'                   'git'
Install-Pkg 'WiresharkFoundation.Wireshark' 'wireshark'
Install-Pkg 'DB Browser for SQLite.DB Browser for SQLite' 'sqlitebrowser'
Install-Pkg 'Microsoft.Sysinternals.ProcessMonitor' 'sysinternals'
Install-Pkg 'Microsoft.Sysinternals.ProcessExplorer' $null

# Burp Suite (install Pro manually for licensed extensions)
Install-Pkg 'PortSwigger.BurpSuite.Community' 'burp-suite-free-edition'
Warn "For Burp Pro + JWT Editor/Autorize/Turbo Intruder, install the licensed build manually."

# Windows SDK provides signtool (Authenticode verification)
if (-not (Have signtool)) {
  Log "Installing Windows SDK (signtool) - this is large"
  Install-Pkg 'Microsoft.WindowsSDK.10.0.22621' 'windows-sdk-10-version-2004-all'
}

# --- Node global tooling (Electron static analysis) --------------------------
Log "Node global tooling"
$env:Path += ";$env:ProgramFiles\nodejs;$env:APPDATA\npm"
foreach ($p in '@electron/asar','@doyensec/electronegativity','retire','js-beautify') {
  if (-not (npm ls -g $p 2>$null | Select-String $p)) { npm install -g $p 2>$null }
}

# --- Python tooling ----------------------------------------------------------
Log "Python tooling"
python -m pip install --upgrade pip 2>$null
foreach ($p in 'mitmproxy','semgrep','pefile') { pip install $p 2>$null }

# --- Claude Code -------------------------------------------------------------
if (-not (Have claude)) { Log "Installing Claude Code"; npm install -g @anthropic-ai/claude-code 2>$null }

Ok "Windows setup complete. Run verify-tools.ps1 to confirm."
Warn "Reminder: do all dynamic/RCE PoC work inside an isolated Windows VM with a clean snapshot."
