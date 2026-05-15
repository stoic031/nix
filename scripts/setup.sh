#!/usr/bin/env bash

set -e

DOTFILES_DIR="$HOME/dotfiles"
DOTFILES_DIR_COMMON="$DOTFILES_DIR/common"
DOTFILES_DIR_MACOS="$DOTFILES_DIR/macos"
DOTFILES_DIR_LINUX="$DOTFILES_DIR/nixos"
GITHUB_URL="https://github.com/stoic031/dotfiles.git"
TPM_DIR="$HOME/.tmux/plugins/tpm"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "${GREEN}[setup]${NC} $1"; }
warn() { echo -e "${YELLOW}[skip]${NC}  $1"; }
err() {
  echo -e "${RED}[error]${NC} $1"
  exit 1
}

if [[ "$(uname -s)" == "Darwin" ]]; then
  BRANCH="macos"
else
  BRANCH="nixos"
fi

log "Detected OS: $(uname -s)"

log "Checking dotfiles..."
if [ ! -d "$DOTFILES_DIR" ]; then
  log "Cloning dotfiles..."
  git clone --depth=1 "$GITHUB_URL" "$DOTFILES_DIR" || err "Failed to clone dotfiles"
else
  warn "Dotfiles already exist, skipping"
fi

log "Stowing configs..."
cd "$DOTFILES_DIR_COMMON"
stow . --target="$HOME" --adopt
if [[ "$(uname -s)" == "Darwin" ]]; then
  log "Stowing config Macos"
  cd "$DOTFILES_DIR_MACOS"
  stow . --target="$HOME/.config" --adopt
else
  log "Stowing config Linux"
  cd "$DOTFILES_DIR_LINUX"
  stow . --target="$HOME/.config" --adopt

fi

log "Checking TPM..."
if [ ! -d "$TPM_DIR" ]; then
  log "Installing TPM..."
  git clone --depth=1 https://github.com/tmux-plugins/tpm "$TPM_DIR" || err "Failed to clone TPM"
  if [ -x "$TPM_DIR/bin/install_plugins" ]; then
    "$TPM_DIR/bin/install_plugins" || warn "Run prefix+I manually"
  fi
else
  warn "TPM already installed, skipping"
fi

log "Done!"
