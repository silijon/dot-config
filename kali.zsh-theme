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
  PR_HOST='%F{red}%M%f' # SSH
else
  PR_HOST='%F{blue}%M%f' # no SSH
fi


local return_code="%(?..%F{red}%? ↵%f)"

local user_host="%B${PR_USER}%F{blue}@${PR_HOST}%b"
local current_dir="%B%F{blue}%~%f%b"
local git_branch='$(git_prompt_info)'

PROMPT="%F{green}╭─(%f${user_host}%F{green})-[%f${current_dir}%F{green}]%f${git_branch}
%F{green}╰─$PR_PROMPT%f "
RPROMPT="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{green}-[%f"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{green}]%f"

PROMPT+='%{$fg[green]%}$(virtualenv_info)%{$reset_color%}%'

}
