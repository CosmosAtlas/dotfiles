# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# Set ENV variables ============================================================
# Expanding path
export PATH=~/Scripts:~/.local/bin:$PATH:~/bin:~/.scripts
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
export PATH=$PATH:~/.node_modules/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/go/bin

# Default programs
export BROWSER=qutebrowser
export TERMINAL=st
export EDITOR=vim
export FZF_DEFAULT_COMMAND='find .'
export HOWDOI_DISABLE_CACHE=1

export LC_ALL=en_US.UTF-8
export COLORTERM=truecolor

# Application specifics

# Consistent QT themes with GTK
export QT_QPA_PLATFORMTHEME=qt5ct

# pfetch
export PF_INFO="ascii title os host kernel uptime memory"
export PF_COLOR=1

# npm
export npm_config_prefix=~/.node_modules

# History ======================================================================
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY_TIME


# My aliases ===================================================================
alias yv='googler -w youtube.com --url-handler umpv $argv'
alias tx='tmuxinator'
alias pc='proxychains -q'
# alias mosh-narf='mosh --server=/home/local/SAIL/cosmos/.linuxbrew/bin/mosh-server narf'
# alias neomutt='pc neomutt'
# alias hangups='pc hangups'
alias lg='lazygit'
alias hugo='PATH=$PWD:$PATH hugo'
alias vw="setsid $BROWSER ~/vimwiki/_site/index.html"
alias vim=nvim
alias vifm=vifmrun
alias sz="setsid zathura"
alias evim="vim -u ~/.dotfiles/essential-vim/.vimrc"

## Window swallowing aliases
alias dm='devour mpv'
alias db='devour biliplay.sh'


# My functions =================================================================
# By setting the global variables might be convenient but, using pc with each program that requires
# the proxy should be the better solution for fine grained control.
proxyon() {
    export http_proxy=http://127.0.0.1:8888
    export https_proxy=http://127.0.0.1:8888
    export HTTP_PROXY=http://127.0.0.1:8888
    export HTTPS_PROXY=http://127.0.0.1:8888
    export ALL_PROXY=socks5://127.0.0.1:8889
    export no_proxy="localhost,miwifi.com,myanonamouse.net"
}

# Automatically enable proxy with the following command
# proxyon

proxyoff() {
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset ALL_PROXY
}


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

vicd() {
  local dst="$(command vifm --choose-dir - "$@")"
  if [ -z "$dst" ]; then
    echo 'Directory picking cancelled/failed'
    return 1
  fi
  cd "$dst"
}

# Intializing functionalities ==================================================
eval "$(fasd --init auto)"

# Set up rust env
[[ ! -f $HOME/.cargo/env ]] || source $HOME/.cargo/env

# Display welcome text =========================================================
type pfetch > /dev/null && pfetch
type $HOME/Repos/Color-Scripts/color-scripts/panes > /dev/null && $HOME/Repos/Color-Scripts/color-scripts/panes
fortune tang300 | ~/.node_modules/bin/cowsay -f yasuna_16

