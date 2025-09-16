#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# -------- Aliases --------
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -al'
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
alias vi='nvim'

# ------- firejail -------
alias obsidian='firejail --noprofile --net=none obsidian'
alias obsidian-net='/usr/bin/obsidian'

# git niceties
alias gpatch='git apply --reject --whitespace=fix -p1'
alias gformat-patch='git format-patch --stdout HEAD^ >'
alias gitsync='git add . && git commit -m "$(date +"%Y-%m-%d %H:%M:%S")" && git push'

PS1='[\u@\h \W]\$ '
