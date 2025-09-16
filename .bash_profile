#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

doas loadkeys "$HOME/.config/loadkeys/loadkeysrc" 2>/dev/null || true

# Default programs
export EDITOR="nvim"
export VISUAL="$EDITOR"
export BROWSER="firefox"
export TERMINAL="st"
export READER="zathura"
export FILE="lf"
export MANPAGER='nvim +Man!'

export GOPATH="$HOME/go/bin"

export PATH="$PATH:$HOME/bin:$GOPATH"

export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# XDG (optional but useful)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"


[ "$(tty)" = "/dev/tty1" ] && startx

