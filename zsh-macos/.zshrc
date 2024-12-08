#
# ${ZDOTDIR:-~}/.zshrc
# Load ZSH plugin management system ===========================================
#
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

antidote load

#
# ENV variables ===============================================================
#
export PATH=~/Scripts:~/.local/bin:$PATH:~/bin:~/.scripts
export PATH=$PATH:~/.cargo/bin

# Default programs
export EDITOR=vim
export FZF_DEFAULT_COMMAND='fd -H .'
export COLORTERM=truecolor

#
# History ======================================================================
#
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY_TIME

#
# Functions ===================================================================
#
colorlist() {
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

truecolortest() {
    awk 'BEGIN{
        s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
        for (colnum = 0; colnum<77; colnum++) {
            r = 255-(colnum*255/76);
            g = (colnum*510/76);
            b = (colnum*255/76);
            if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum+1,1);
        }
        printf "\n";
    }'
}

dotupdate() {
  if [ -d ~/.emacs.d ]; then
    echo "Pulling ~/.emacs.d"
    git -C ~/.emacs.d/ pull
  else
    echo "~/.emacs.d doesn't exist, skipping..."
  fi
  if [ -d ~/.dotfiles ]; then
    echo "Pulling ~/.dotfiles"
    git -C ~/.dotfiles/ pull
  else
    echo "~/.dotfiles doesn't exist, skipping..."
  fi
}


function auto_pipenv_shell {
    if [ ! -n "${PIPENV_ACTIVE+1}" ]; then
        if [ -f "Pipfile" ] ; then
            pipenv shell
        fi
    fi
}

# Overwrite cd command
function cd {
    builtin cd "$@"
    auto_pipenv_shell
}


#
# Finish Ups ==================================================================
#

# Setup pyenv information
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Set up rust env
[[ ! -f $HOME/.cargo/env ]] || source $HOME/.cargo/env

# Start prompt
eval "$(starship init zsh)"

auto_pipenv_shell

# Display welcome text
type pfetch > /dev/null && pfetch
