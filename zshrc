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
export PATH="$HOME/.local/bin:$PATH"
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
alias h='hisyory'
alias q='exit'
alias r='reset'
alias ls='eza --icons'
alias la='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias p='python'
alias libtoolize='glibtoolize'

# Custom commands
alias poweroff='sudo shutdown -h now'
alias v='$EDITOR'
alias nano='$EDITOR'
alias n='$EDITOR'
alias vim='$EDITOR'
export EDITOR=nvim

# Auto ls after cd
cd() {
    builtin cd "$@" && ls
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Java Home Path for JDK 22 deault
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"

# Rust Path
export PATH="$HOME/.cargo/bin:$PATH"

# Auto command suggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#FFE6F2, bold'
source /Users/owo/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
