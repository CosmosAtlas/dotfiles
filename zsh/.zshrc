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

#zmodload zsh/zprof

export PATH=~/go/bin:~/.local/bin/:$PATH:~/.gem/ruby/2.6.0/bin/:~/bin/:~/.scripts/
export BROWSER=chromium
export SPACESHIP_TIME_SHOW=true
export EDITOR=vim
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
)

export KEYTIMEOUT=1

# Load autojump
source /etc/profile.d/autojump.zsh

# Randomly display 1 of 2 random welcome messages
if (( RANDOM % 2 )); then
    neofetch
else
    pokemonsay Have a nice day!
fi

source ~/.commacd.sh
source ~/.scripts/wu

# only load nvm when used
nvm() {
    echo "NVM not loaded! Loading now..."
    unset -f nvm
    source /usr/share/nvm/init-nvm.sh
    nvm "$@"
}

#zprof

alias neomutt='TERM=screen-256color neomutt'
