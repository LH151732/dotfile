#!bin/zsh
neofetch

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/texlive/2024/bin/universal-darwin:$PATH"
export TCL_LIBRARY="/opt/homebrew/opt/tcl-tk/lib"
export TK_LIBRARY="/opt/homebrew/opt/tcl-tk/lib"
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
