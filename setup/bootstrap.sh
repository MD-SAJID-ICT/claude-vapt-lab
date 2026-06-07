#!/usr/bin/env bash
# One-line onboarding for a Linux host: clone-or-pull the repo, then install the toolchain.
# Usage: curl -fsSL <raw>/setup/bootstrap.sh | bash -s -- <repo-url> [target-dir]
set -uo pipefail
REPO="${1:-}"; DIR="${2:-claude-vapt-lab}"
log(){ printf '\033[1;34m[*]\033[0m %s\n' "$*"; }
if [[ -z "$REPO" && ! -d .git ]]; then echo "Usage: bootstrap.sh <repo-url> [dir]"; exit 1; fi
if [[ -d "$DIR/.git" ]]; then log "Updating $DIR"; git -C "$DIR" pull --ff-only;
elif [[ -d .git ]]; then log "Already in a clone; pulling"; git pull --ff-only; DIR=".";
else log "Cloning $REPO"; git clone "$REPO" "$DIR"; fi
cd "$DIR"
log "Running Linux setup"
bash setup/kali-setup.sh
bash setup/verify-tools.sh
log "Done. Launch with:  cd $DIR && claude"
