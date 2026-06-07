<#
 One-line onboarding for Windows: clone-or-pull the repo, then install the toolchain.
 Usage (elevated PowerShell):
   $env:REPO="<repo-url>"; iwr -useb <raw>/setup/bootstrap.ps1 | iex
 or:  .\bootstrap.ps1 -Repo <repo-url> [-Dir claude-vapt-lab]
#>
param([string]$Repo = $env:REPO, [string]$Dir = "claude-vapt-lab")
$ErrorActionPreference = 'Stop'
function Log($m){ Write-Host "[*] $m" -ForegroundColor Cyan }
if (Test-Path "$Dir/.git") { Log "Updating $Dir"; git -C $Dir pull --ff-only }
elseif (Test-Path ".git") { Log "Already in a clone; pulling"; git pull --ff-only; $Dir = "." }
elseif ($Repo) { Log "Cloning $Repo"; git clone $Repo $Dir }
else { Write-Host "Provide -Repo <url> or set `$env:REPO"; exit 1 }
Set-Location $Dir
Log "Running Windows setup (must be elevated)"
powershell -ExecutionPolicy Bypass -File .\setup\windows-setup.ps1
Log "Done. Launch with:  cd $Dir ; claude"
