if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

# env niceness
set -o vi
export CLICOLOR=1

. /etc/git-completion.bash
[ -r /etc/git-prompt.sh ] && . /etc/git-prompt.sh

export PS1='\[\033[0;35m\]\h\[\033[0;33m\] \w\[\033[00m\]: '

# non-printable characters must be enclosed inside \[ and \]
#export PS1='\[\033]0;$MSYSTEM:\w\007\]' # set window title
#PS1="$PS1"'\n'                 # new line
#PS1="$PS1"'\[\033[32m\]'       # change color
#PS1="$PS1"'\u@\h '             # user@host<space>
#PS1="$PS1"'\[\033[33m\]'       # change color
#PS1="$PS1"'\w'                 # current working directory
if test -z "$WINELOADERNOEXEC"
then
    PS1='$(__git_ps1)'"$PS1"  # bash function
fi
#PS1="$PS1"'\[\033[0m\]'        # change color
#PS1="$PS1"'\n'                 # new line
#PS1="$PS1"'$ '                 # prompt: always $


# host shortcuts
export JD=john@johnwdennis.com
export SITH=jdennis@sith.ucsfmedicalcenter.org
export LOTUS="lotusfir@lotusfireproductions.com"
export CL="jdennis@chiulab.ucsfmedicalcenter.org"
#export CV="ubuntu@ec2-107-21-143-102.compute-1.amazonaws.com"
export SK1="ubuntu@107.22.245.129"
export SK2="ubuntu@184.73.254.141"
export SK2IP="184.73.254.141"

# command shortcuts
alias grep='grep --color'
alias ls='ls --color=tty'
alias l='ls -hal'
alias ll='l |less'
alias serve='python -m SimpleHTTPServer'

# win specific
alias open='cygstart'
alias gvim='"/cygdrive/c/Program Files (x86)/Vim/vim74/gvim.exe"'
alias xwin='XWin -nodecoration -rootless'

grepNoCRLF()
{
    grep -Erino ".{0,80}$1.{0,80}" $2
}
alias bgrep=grepNoCRLF


