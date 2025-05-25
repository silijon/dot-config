# Based on bira theme

setopt prompt_subst

() {

local PR_USER PR_USER_OP PR_PROMPT PR_HOST

# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
  PR_USER='%F{blue}%n%f'
  PR_USER_OP='%F{blue}%#%f'
  PR_PROMPT='%F{green}➤ %f'
else # root
  PR_USER='%F{red}%n%f'
  PR_USER_OP='%F{red}%#%f'
  PR_PROMPT='%F{red}➤ %f'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%F{blue}%M%f' # SSH
else
  PR_HOST='%F{blue}%M%f' # no SSH
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%F{green}-[%f"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{green}]%f"

ZSH_THEME_VIRTUALENV_PREFIX="%F{green}-[%f"
ZSH_THEME_VIRTUALENV_SUFFIX="%F{green}]%f"

function conda_prompt_info {
  if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
    echo "${ZSH_THEME_VIRTUALENV_PREFIX}${CONDA_DEFAULT_ENV}${ZSH_THEME_VIRTUALENV_SUFFIX}"
  fi
}

local return_code="%(?..%F{red}%? ↵%f)"
local user_host="%B${PR_USER}%F{blue}@${PR_HOST}%b"
local current_dir="%B%F{blue}%~%f%b"
local git_branch='$(git_prompt_info)'
local python_venv='$(virtualenv_prompt_info)'
local conda_env='$(conda_prompt_info)'

PROMPT="%F{green}╭─(%f${user_host}%F{green})-[%f${current_dir}%F{green}]%f${python_venv}${conda_env}${git_branch}
%F{green}╰─$PR_PROMPT%f "
RPROMPT="${return_code}"

}
