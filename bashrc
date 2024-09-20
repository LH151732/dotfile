#!/bin/bash
neofetch

# prompt
source /usr/share/git/completion/git-prompt.sh
PS1='\n\n\n\[\033[01;32m\]┌───[\[\033[01;36m\]\u\[\033[00m\]:\[\033[01;36m\]\h\[\033[00m\]] - \[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\] $(git symbolic-ref --short HEAD 2>/dev/null | sed "s/.*/ &/")\n\[\033[01;32m\]│\[\033[00m\]\n\[\033[01;32m\]│\n\[\033[01;32m\]└─% \[\033[00m\]'

# alias
alias ll='eza --icons --group-directories-first --sort=extension -l'
alias la='eza --icons --group-directories-first --sort=extension -a'
alias ls='eza --icons --group-directories-first --sort=extension'
alias lla='eza --icons --group-directories-first --sort=extension -la'
alias cdd='cd ..'
alias git='cd /mnt/hdd1/Git/'
alias des='cd ~/Desktop'
alias doc='cd ~/Documents/'
alias dow='cd ~/Downloads/'
alias open='xdg-open'
alias vi='nvim'
alias n='nvim'
alias nano='nvim'
alias vim='nvim'
alias grep='grep --color=auto'
alias cat='bat'
alias gc='git clone'
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gco='git chectout'
alias q='exit'
alias c='clear'
alias r='clear && bash'
alias h='history'
alias p='pwd'
alias p='python'
alias j='java'
alias g='go'
alias d='docker'
alias rs='rustc'
alias f='find'
alias m='make'
alias t='tree'
alias pac='sudo pacman'

# export
export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
# sdk
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# auto 'ls' after 'cd'
cd() {
  builtin cd "$@" && ls
}

# y
function y() {
  tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
