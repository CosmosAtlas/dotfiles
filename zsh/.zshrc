# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# My plugins ===================================================================
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

zinit light ael-code/zsh-colored-man-pages
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
zinit light romkatv/powerlevel10k

# Set ENV variables ============================================================
# Expanding path
export PATH=~/Scripts:~/.local/bin:$PATH:~/bin:~/.scripts
export PATH=~/.xmonad:$PATH
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
export PATH=$PATH:~/.node_modules/bin
# export PATH=$PATH:~/.cargo/bin
export BROWSER=qutebrowser
export TERMINAL=st
export EDITOR=vim
export FZF_DEFAULT_COMMAND='find .'

# Application specifics

# pfetch
export PF_INFO="ascii title os host kernel uptime memory"
export PF_COLOR=1

# npm
export npm_config_prefix=~/.node_modules

# History ======================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY_TIME


# My aliases ===================================================================
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


# My functions =================================================================
# By setting the global variables might be convenient but, using pc with each program that requires
# the proxy should be the better solution for fine grained control.
proxyon() {
    export http_proxy=192.168.31.202:8888
    export https_proxy=192.168.31.202:8888
    export ALL_PROXY=192.168.31.202:8889
}

proxyoff() {
    unset http_proxy 
    unset https_proxy 
    unset ALL_PROXY
}


colorlist() {
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

# Intializing functionalities ==================================================
eval "$(fasd --init auto)"

# Set up rust env
# source $HOME/.cargo/env

# set proxy
proxyon

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Display welcome text =========================================================
type pfetch > /dev/null && pfetch
type $HOME/Repos/Color-Scripts/color-scripts/panes > /dev/null && $HOME/Repos/Color-Scripts/color-scripts/panes

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
