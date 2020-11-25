# ~/.zshrc
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Start of antibody
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

# End of antibody

# Auto completion
autoload -Uz compinit
compinit

export PATH=~/Scripts:~/.local/bin:$PATH:~/.gem/ruby/2.6.0/bin:~/bin:~/.scripts
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
export PATH=$PATH:~/.node_modules/bin
export PATH=$PATH:~/.cargo/bin
export BROWSER=qutebrowser
export TERMINAL=st
export SPACESHIP_TIME_SHOW=true
export EDITOR=vim
export FZF_DEFAULT_COMMAND='find .'

# Prompt Configuration
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  exit_code     # Exit code section
  char          # Prompt character
  venv          # virtualenv section
)

bindkey -v "^?" backward-delete-char

export KEYTIMEOUT=1

# load fasd for fast navigation
eval "$(fasd --init auto)"

alias pfetch='PF_INFO="ascii title os host kernel uptime memory" pfetch'

# Substring search settings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY_TIME

# Update prompt time every 30 secs
TRAPALRM() {
    zle reset-prompt
}
TMOUT=30

set -o vi

# My aliases
alias yv='googler -w youtube.com --url-handler umpv $argv'
alias tx='tmuxinator'
alias pc='proxychains -q'
alias mosh-narf='mosh --server=/home/local/SAIL/cosmos/.linuxbrew/bin/mosh-server narf'
alias mount-win='sudo mount -t cifs -o username=cosmos,rw,uid=$USER,gid=$USER,dir_mode=0755,file_mode=0664 //192.168.31.157/d /home/cosmos/Mounts/ExtWin'
alias aria-win='setsid aria2c --conf-path ~/.config/aria2/win-aria2.conf -D'
alias neomutt='pc neomutt'
alias hangups='pc hangups'
alias lg='lazygit'
alias hugo='PATH=$PWD:$PATH hugo'
alias vim=nvim

## Window swallowing aliases
alias dm='devour mpv'
alias dp='devour qlphelper -u'
alias db='devour biliplay.sh'

# environment control variables
export VIMWIKI_MARKDOWN_EXTENSIONS="markdown_checklist.extension"

# By setting the global variables might be convenient but, using pc with each program that requires
# the proxy should be the better solution for fine grained control.
proxyon() {
    export http_proxy=http://127.0.0.1:8888
    export https_proxy=http://127.0.0.1:8888
    export ALL_PROXY=http://127.0.0.1:8888
}

proxyoff() {
    unset http_proxy 
    unset https_proxy 
    unset ALL_PROXY
}

proxyon

export npm_config_prefix=~/.node_modules

# Set up rust env
source $HOME/.cargo/env

# unlimited ulimit
ulimit -u unlimited
ulimit -s 65536

# initiate prompt
eval "$(starship init zsh)"

pfetch
$HOME/Repos/Color-Scripts/color-scripts/panes
fortune tang300 | ~/.node_modules/bin/cowsay -f sachiko
