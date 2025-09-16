#!/usr/bin/env bash
set -eu

BACKUP_DIR="$HOME/.dotfiles"

FILES=(
  ".zprofile"
  ".xinitrc"
  ".bashrc"
  ".bash_profile"
  ".xinitrc"
  ".gitconfig"

  ".config/fontconfig"
  ".config/loadkeys"
  ".config/sxhkd"
  ".config/zathura"
  ".config/zsh/.zshrc"

  ".local/share/fonts"
)

mkdir -p "$BACKUP_DIR"

for f in "${FILES[@]}"; do
  mkdir -p "$BACKUP_DIR/$(dirname "$f")"
  rsync -ahcviP --delete --inplace "$HOME/$f" "$BACKUP_DIR/$(dirname "$f")/"
done

