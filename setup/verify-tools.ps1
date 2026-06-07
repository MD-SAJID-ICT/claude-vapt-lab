# Verify Windows toolchain. Run: powershell -ExecutionPolicy Bypass -File verify-tools.ps1
function Check($c){ if (Get-Command $c -ErrorAction SilentlyContinue){ Write-Host "[+] $c" -ForegroundColor Green } else { Write-Host "[-] $c MISSING" -ForegroundColor Red } }
"node","npm","python","pip","git","7z","signtool","claude" | ForEach-Object { Check $_ }
"asar","electronegativity","retire","js-beautify" | ForEach-Object { if (npm ls -g $_ 2>$null | Select-String $_){ Write-Host "[+] $_ (npm -g)" -ForegroundColor Green } else { Write-Host "[-] $_ (npm -g) MISSING" -ForegroundColor Red } }
Write-Host "Also confirm (GUI): Burp Suite, Wireshark, Sysinternals (Procmon/Procexp), DB Browser for SQLite."
