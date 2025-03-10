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
export FZF_DEFAULT_COMMAND='rg --files --hidden'
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

#
# uv for python finalizing ====================================================
#
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

pyenv() {
  if [ "$1" = "version-name" ]; then
    uv run python --version | sed 's/Python //g'
  else
    echo "pyenv: command not found"
  fi
}


#
# Finish Ups ==================================================================
#

# Set up rust env
[[ ! -f $HOME/.cargo/env ]] || source $HOME/.cargo/env

# Start prompt
eval "$(starship init zsh)"

# Load local config file
[[ ! -f $HOME/.zsh_local ]] || source $HOME/.zsh_local

# Display welcome text
type pfetch > /dev/null && pfetch
