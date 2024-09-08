#!bin/zsh
neofetch
start_if_not_running() {
    if ! pgrep -x "$1" > /dev/null; then
        nohup "$1" > /dev/null 2>&1 &
    fi
}

start_if_not_running "yabai"
start_if_not_running "skhd"
start_if_not_running "sketchybar"
export PATH="/opt/homebrew/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"
export EDITOR=nvim

precmd() {
  print
}

# 设置自定义命令提示符
PROMPT='
┌───[%n:%m] - %~ 
│  
└─%# '

# 设置窗口标题
recmd () { print -Pn "\e]2;OWO@WORKING..: %~\a" }

# 启用颜色支持
export CLICOLOR=1

# General
alias c='clear'
alias ls='eza --icons'
alias la='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias p='python'
alias python='python3'
alias pip='pip3'
alias libtoolize='glibtoolize'


# Custom commands
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias nano='$EDITOR'
alias n='$EDITOR'
alias vim='$EDITOR'
export EDITOR=nvim


# 进入路径后自动ls
cd() {
    builtin cd "$@" && ls
}
