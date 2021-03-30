# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ~/.zshrc

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
export EDITOR=vim
export FZF_DEFAULT_COMMAND='find .'

# # Prompt Configuration
# export SPACESHIP_TIME_SHOW=true
# SPACESHIP_PROMPT_ORDER=(
#   time          # Time stamps section
#   user          # Username section
#   dir           # Current directory section
#   host          # Hostname section
#   git           # Git section (git_branch + git_status)
#   exec_time     # Execution time
#   line_sep      # Line break
#   vi_mode       # Vi-mode indicator
#   exit_code     # Exit code section
#   char          # Prompt character
#   venv          # virtualenv section
# )

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
# TRAPALRM() {
#     zle reset-prompt
# }
# TMOUT=30

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
alias vw="setsid $BROWSER ~/vimwiki/_site/index.html"
alias vim=nvim
alias vifm=vifmrun

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
    export ALL_PROXY=socks5://127.0.0.1:8889
}

proxyoff() {
    unset http_proxy 
    unset https_proxy 
    unset ALL_PROXY
}


colorlist() {
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

proxyon

export npm_config_prefix=~/.node_modules

# Set up rust env
source $HOME/.cargo/env

# unlimited ulimit
ulimit -u unlimited
ulimit -s 65536

# initiate prompt
# eval "$(starship init zsh)"

# Display welcome text
type pfetch > /dev/null && pfetch
type $HOME/Repos/Color-Scripts/color-scripts/panes > /dev/null && $HOME/Repos/Color-Scripts/color-scripts/panes
fortune tang300 | ~/.node_modules/bin/cowsay -f sachiko

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
