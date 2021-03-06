source ~/git-prompt.sh

# env niceness
set -o vi
export CLICOLOR=1
export PS1="\$(__git_ps1)\[\033[0;35m\]\h\[\033[0;33m\] \w\[\033[00m\]: "
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# path mods
export PATH=~/.local/bin:~/.dotnet:$PATH

# home vars
export PYTHON_HOME=/usr/local
export EDITOR=/usr/bin/vim

# host shortcuts
export JD=john@johnwdennis.com
export SITH=jdennis@sith.ucsfmedicalcenter.org
export LOTUS=lotusfir@lotusfireproductions.com
export CL=jdennis@chiulab.ucsfmedicalcenter.org
#export CV=ubuntu@ec2-107-21-143-102.compute-1.amazonaws.com
export SK1=ubuntu@107.22.245.129
export SK2=ubuntu@184.73.254.141
export SK2IP=184.73.254.141
export DOCKER_HOST=tcp://localhost:2375

# command shortcuts
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
if [[ `uname` != 'Darwin' ]]; then
    alias ls='ls --color=tty'
fi
alias l='ls -hal'
alias ll='l |less'
alias tmux='TERM=xterm-256color tmux'
alias myip='curl http://icanhazip.com'
alias gvim='/mnt/c/Program\ Files\ \(x86\)/Vim/vim80/gvim.exe'

# funcs
serve () {
    python -m SimpleHTTPServer $1
}
