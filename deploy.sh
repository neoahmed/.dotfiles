#!/usr/bin/env bash
set -eu

# cd into source dir which is .dotfiles project and where this script lives
cd "$(dirname "$0")"

# Only top-level .dotfiles/dirs in the repo; skip project related files
find . -mindepth 1 -maxdepth 1 -name ".*" -print0 |
while IFS= read -r -d '' f; do
  case "$f" in
    ./deploy.sh|./sync.sh|./.git/.gitignore) continue ;;
  esac

  dst=${f#./}                        # strip leading ./ for destination path
  mkdir -p "$HOME/$(dirname "$dst")"

  if [ -d "$f" ]; then
    # directory: mirror contents
    rsync -avhciP --inplace "./${dst%/}/" "$HOME/${dst%/}/"
  else
    # file: just copy
    rsync -avhciP --inplace "./$dst" "$HOME/$dst"
  fi
done

