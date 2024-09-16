#!/bin/zsh

# System Info
neofetch

# Functions
start_if_not_running() {
    if ! pgrep -x "$1" > /dev/null; then
        nohup "$1" > /dev/null 2>&1 &
    fi
}

start_if_not_running "yabai"
start_if_not_running "skhd"
start_if_not_running "sketchybar"

# Environment Variables
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"
export EDITOR=nvim
export CLICOLOR=1

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Zsh Plugins
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#FFE6F2, bold'
source /Users/owo/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Custom Commands and Aliases
alias c='clear'
alias h='hisyory'
alias q='exit'
alias r='reset'
# 修改后的 eza 别名，添加排序选项
alias ls='eza --icons --group-directories-first --sort=extension'
alias la='eza -a --icons --group-directories-first --sort=extension'
alias ll='eza -al --icons --group-directories-first --sort=extension'
alias lt='eza -a --tree --level=1 --icons --group-directories-first --sort=extension'
alias p='python'
alias libtoolize='glibtoolize'
alias poweroff='sudo shutdown -h now'
alias v='$EDITOR'
alias nano='$EDITOR'
alias n='$EDITOR'
alias vim='$EDITOR'

# Auto `ls` after `cd`
cd() {
    builtin cd "$@" && ls
}

# PDF Conversion from Markdown
mdpdf() {
    input_file="$1"
    output_file="${input_file%.*}.pdf"
    pandoc "$input_file" -o "$output_file" --pdf-engine=xelatex --toc
}

# Prompt and Command Display Settings
precmd() {
  print
}

PROMPT='
┌───[%n:%m] - %~ 
│  
└─%# '

recmd () { print -Pn "\e]2;OWO@WORKING..: %~\a" }

# Zoxide Initialization
eval "$(zoxide init zsh)"

# Custom `yazi` Command Function
function y() {
  tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
