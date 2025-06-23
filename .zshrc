###############################################################################
# zsh/omz setup 
###############################################################################
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="kali"

plugins=(
    vi-mode
    sudo
    debian
    systemd
    git
    dotnet
    node
    npm
    nvm
    virtualenv
    python
    pip
    zoxide
)

# Source OMZ
source $ZSH/oh-my-zsh.sh

# Download Znap, if it's not there yet.
[[ -r ~/.config/zsh/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.config/zsh/znap
source ~/.config/zsh/znap/znap.zsh  # Start Znap

# Znap plugins
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
bindkey '^t' autosuggest-accept

# Fix autosuggestion colors 
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#777777'


###############################################################################
# user environment 
###############################################################################
if [[ -z "$LS_COLORS" ]]; then # ensure ls colors work with non-standard terms
  eval "$(TERM=xterm-256color dircolors -b)"
fi

# aliases
export PATH="$HOME/.local/bin:$PATH"
export EDITOR='nvim'

alias todo="vim $HOME/Dropbox/Documents/todo.txt"
alias myip='curl http://icanhazip.com'
alias l='ls -hal --color'
alias ll='ls -hal --color |less'
alias fd='fdfind --hidden --no-ignore' # show hidden and don't respect .gitignore (who comes up with these defaults?)
alias gd='git diff --name-only --relative --diff-filter=d |xargs bat --diff'
alias ranger='source ranger' # drops you into currently selected dir when exiting ranger
alias ipython='ipython --no-autoindent' # autoindent messes with cut/paste and nvim send-to-term

# functions
genpwd() {
  local length=${1:-20}
  LC_ALL=C tr -dc 'A-Za-z0-9!@#$%^&*()_+=-' < /dev/urandom | head -c "$length"
  echo
}


###############################################################################
# specific packages 
###############################################################################

# dotnet
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$DOTNET_ROOT:$PATH"

# go
export PATH="/usr/local/go/bin:$HOME/go/bin:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# vcpkg
export VCPKG_ROOT="$HOME/.local/share/vcpkg/"
export PATH="$VCPKG_ROOT:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# conda
export CONDA_CHANGEPS1=false # disable default env name in prompt
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(\"$HOME/miniforge3/bin/conda\" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# mamba
export MAMBA_CHANGEPS1=false
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE="$HOME/miniforge3/bin/mamba";
export MAMBA_ROOT_PREFIX="$HOME/miniforge3";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
