#~/.config/zsh/.zshrc

# if not interactive, don't do anything
[[ -o interactive ]] || return

autoload -U colors && colors

# -------- Prompt (truecolor) --------
# Use printf to get a real ESC character and wrap non-printing sequences in %{
if [[ "$TERM" = "st-256color" || "$TERM" = "xterm-256color" ]]; then
  FOLDER_COLOR=$(printf '\033[1;38;2;125;174;163m')   # #7daea3
  ARROW_COLOR=$(printf '\033[1;38;2;234;105;98m')    # #ea6962
  RESET=$(printf '\033[0m')

  # PROMPT_SUBST allows variable expansion inside PROMPT
  setopt PROMPT_SUBST
  PROMPT="%{${FOLDER_COLOR}%}%1~ %{$ARROW_COLOR%}> %{$RESET%}"
else
  PS1='[%n@%m %1~]$ '
fi

# -------- History --------
if [ -f "$HOME/.zsh_history" ]; then
  HISTFILE="$HOME/.zsh_history"
else
  mkdir -p "$HOME/.cache/zsh"
  HISTFILE="$HOME/.cache/zsh/history"
fi
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY SHARE_HISTORY

# -------- Completion --------
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)    # include hidden files in completion

# Run compinit safely (avoid insecure dir warnings)
autoload -Uz compinit
compinit -u 2>/dev/null || compinit 2>/dev/null

# -------- Keybindings & vi mode --------
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in menuselect
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Backspace and Delete behaviour
bindkey -M viins $'\e[P' delete-char
bindkey $'\e[P' delete-char

bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^L' delete-char

# -------- Debounced cursor-shape switching (reduce flicker) --------
# Only enable when terminal is likely to support DECSTBM cursor shape.
if [[ "$TERM" = "st-256color" ]]; then
  typeset -g __ZSH_CUR_KEYMAP=""

  zle-keymap-select() {
    local km=${KEYMAP:-main}
    [[ $km == $__ZSH_CUR_KEYMAP ]] && return
    __ZSH_CUR_KEYMAP=$km

    if [[ $km == vicmd ]]; then
      printf '\e[1 q' > /dev/tty    # block cursor in command mode
    else
      printf '\e[5 q' > /dev/tty    # beam cursor in insert mode
    fi
  }
  zle -N zle-keymap-select

  zle-line-init() {
    zle -K viins
    printf '\e[5 q' > /dev/tty
  }
  zle -N zle-line-init
fi

# -------- Utilities (lf, edit-line) --------
lfcd() {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}
bindkey -s '^f' 'lfcd\n'

autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# -------- Aliases --------
alias ls='ls --color=auto'
alias ll='ls -al'
alias grep='grep --color=auto'
alias i='doas pacman -Sy --needed'
alias u='doas pacman -Syu --needed'
alias r='doas pacman -Rns'
alias q='doas pacman -Ss'
alias pm-search='doas pacman -Q'
alias pm-count='doas pacman -Qen | wc -l'
alias pm-count-aur='doas pacman -Qem | wc -l'
alias pm-count-all='doas pacman -Q | wc -l'
alias pm-list='doas pacman -Qenq'
alias pm-list-aur='doas pacman -Qemq'
alias pm-orphans='doas pacman -Qdt'
alias pmc='doas pacman -Sc'
alias pm-since='f() { awk -v d="[$1]" '\''$1 >= d && $3=="installed"{print $4}'\'' /var/log/pacman.log; }; f' # YYYY-MM_DD as a parameter
alias vi='nvim'

# ------- firejail -------
alias obsidian='firejail --noprofile --net=none obsidian'
alias obsidian-net='/usr/bin/obsidian'

# -------- Plugins --------
#

# zsh-autosuggestions
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
fi

# zsh-history-substring-search
if [ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey '^P' history-substring-search-up
  bindkey '^N' history-substring-search-down
fi

# zsh-syntax-highlighting
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

