# git niceness
export GIT_PS1_SHOWDIRTYSTATE=1

# env niceness
set -o vi
export CLICOLOR=1
export PS1="\[\033[01;32m\]\h\[\033[01;34m\] \w\[\033[35m\]\$(__git_ps1)\[\033[00m\]: "
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# path mods
export PATH=~/.local/bin:~/.dotnet:$PATH

# home vars
export EDITOR=/usr/bin/vim

# command shortcuts
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
if [[ `uname` != 'Darwin' ]]; then
    alias ls='ls --color=tty'
fi
alias l='ls -hal --color'
alias ll='l |less'
alias less='less -r'
alias tmux='TERM=xterm-256color tmux'
alias myip='curl http://icanhazip.com'
alias gvim='/mnt/c/Program\ Files\ \(x86\)/Vim/vim80/gvim.exe'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
