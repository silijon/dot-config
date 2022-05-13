#source ~/git-prompt.sh

# env niceness
set -o vi
export CLICOLOR=1
export PS1="\$(__git_ps1)\[\033[0;35m\]\h\[\033[0;33m\] \w\[\033[00m\]: "
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
alias tmux='TERM=xterm-256color tmux'
alias myip='curl http://icanhazip.com'
alias gvim='/mnt/c/Program\ Files\ \(x86\)/Vim/vim80/gvim.exe'
