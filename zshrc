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

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

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
alias pgadmin='python /Applications/pgAdmin 4.app/Contents/Resources/web/pgAdmin4.py'
alias ctags='/opt/homebrew/opt/universal-ctags/bin/ctags'
alias c='clear'
alias h='hisyory'
alias q='exit'
alias r='reset'
# direction
alias cdd='cd ..'
alias des='cd  ~/Desktop/'
alias doc='cd ~/Documents/'
alias dow='cd ~/Downloads/'
alias Git='cd ~/Desktop/Git/'
alias conf='cd ~/.config/'
# 修改后的 eza 别名，添加排序选项
alias ls='eza --icons --group-directories-first --sort=extension'
alias la='eza -a --icons --group-directories-first --sort=extension'
alias ll='eza -al --icons --group-directories-first --sort=extension'
alias lt='eza -a --tree --level=1 --icons --group-directories-first --sort=extension'
alias cat='bat'
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

# 加载 git-prompt.sh 脚本
source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh

# 启用 PROMPT_SUBST 选项，以便在 PROMPT 中自动解析变量
setopt PROMPT_SUBST

# 定义一个变量来存储 Git 分支信息
git_branch=""

# 使用 precmd 函数在每次显示提示符之前更新 Git 分支信息
precmd() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    git_branch="%F{208}  $(git branch --show-current)%f"  # 使用橙色显示 Git 分支
  else
    git_branch=""  # 非 Git 仓库则清空分支信息
  fi
}

# 设置 PROMPT，使用 git_branch 变量，并调整颜色
PROMPT='

%F{81}┌───[%F{121}HL%f:%F{121}HL%f] - %F{75}%~%f${git_branch}
%F{81}│
%F{81}└─%# %f'

# recmd 函数用来更新终端窗口标题
recmd () { print -Pn "\e]2;CHOQWORKING..:%~\a" }
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

# start ssh-agent
eval "$(ssh-agent -s)"

# add ssh key
alias HL='ssh-add ~/.ssh/id_rsa'
