#!/bin/bash
iatest=$(expr index "$-" i)

#######################################################
# SOURCED ALIAS'S AND SCRIPTS BY zachbrowne.me
#######################################################

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

#######################################################
# EXPORTS
#######################################################

# Disable the bell
if [[ $iatest > 0 ]]; then bind "set bell-style visible"; fi

# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=5000

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# Set the default editor
export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# nvm stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

#######################################################
# MACHINE SPECIFIC ALIAS'S
#######################################################

#######################################################
# GENERAL ALIAS'S
#######################################################
# To temporarily bypass an alias, we preceed the command with a \
# EG: the ls command is aliased, but to use the normal ls command you would type \ls

# Show help for this .bashrc file
# alias to show the date
alias da='date "+%Y-%m-%d %A %T %Z"'

# Alias's to modified commands
alias mkdir='mkdir -p'

# ls
alias ls='ls -h --color=always' # Always human readable and in color
alias l='ls -1'                 # l  -> one column
alias ll='ls -Al'               # ll -> almost all long
alias la='ls -alF'              # la -> all + type at end

# start vim
alias vim='nvim'

# Lazygit
alias lg='lazygit'

#######################################################
# SPECIAL FUNCTIONS
#######################################################

# Extracts any archive(s) (if unp isn't installed)
extract() {
  for archive in $*; do
    if [ -f $archive ]; then
      case $archive in
      *.tar.bz2) tar xvjf $archive ;;
      *.tar.gz) tar xvzf $archive ;;
      *.bz2) bunzip2 $archive ;;
      *.rar) rar x $archive ;;
      *.gz) gunzip $archive ;;
      *.tar) tar xvf $archive ;;
      *.tbz2) tar xvjf $archive ;;
      *.tgz) tar xvzf $archive ;;
      *.zip) unzip $archive ;;
      *.Z) uncompress $archive ;;
      *.7z) 7z x $archive ;;
      *) echo "don't know how to extract '$archive'..." ;;
      esac
    else
      echo "'$archive' is not a valid file!"
    fi
  done
}

parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

#######################################################
# Set the ultimate amazing command prompt
#######################################################

alias cpu="grep 'cpu ' /proc/stat | awk '{usage=(\$2+\$4)*100/(\$2+\$4+\$5)} END {print usage}' | awk '{printf(\"%.1f\n\", \$1)}'"
function __setprompt {
  local LAST_COMMAND=$? # Must come first!

  # Define colors
  local LIGHTGRAY="\033[0;37m"
  local WHITE="\033[1;37m"
  local BLACK="\033[0;30m"
  local DARKGRAY="\033[1;30m"
  local RED="\033[0;31m"
  local LIGHTRED="\033[1;31m"
  local GREEN="\033[0;32m"
  local LIGHTGREEN="\033[1;32m"
  local BROWN="\033[0;33m"
  local BBROWN="\033[1;33m"
  local YELLOW="\033[1;33m"
  local BLUE="\033[0;34m"
  local LIGHTBLUE="\033[1;34m"
  local MAGENTA="\033[0;35m"
  local LIGHTMAGENTA="\033[1;35m"
  local CYAN="\033[0;36m"
  local LIGHTCYAN="\033[1;36m"
  local NOCOLOR="\033[0m"

  PS1=""

  # Show if root (usually does not apply, since this config is just for ~)
  if [[ $EUID -eq 0 ]]; then
    PS1+="[\[${LIGHTRED}\]\u\[${NOCOLOR}\]]"
  fi

  # Current directory
  PS1+="\[${BBROWN}\]\W "

  # git branch
  PS1+="\[${LIGHTBLUE}\]\$(parse_git_branch)\[${NOCOLOR}\]"

  # show ">"
  if [[ $EUID -ne 0 ]]; then
    PS1+="\[${LIGHTGREEN}\]>\[${NOCOLOR}\] " # Normal user
    PS2="\[${LIGHTGREEN}\]>\[${NOCOLOR}\] "
  else
    PS1+="\[${LIGHTRED}\]>\[${NOCOLOR}\] " # Root user
    PS2="\[${LIGHTRED}\]>\[${NOCOLOR}\] "
  fi

  # PS3 is used to enter a number choice in a script
  PS3='Please enter a number from above list: '

  # PS4 is used for tracing a script in debug mode
  PS4="\[${DARKGRAY}\]+\[${NOCOLOR}\] "

}
PROMPT_COMMAND='__setprompt'

# Additional sources
# Deno
if [ -e "$HOME/.deno/env" ]; then
  . "$HOME/.deno/env"
fi
# homebrew
if [ -d /home/linuxbrew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# proto
export PROTO_HOME="$HOME/.proto"
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"

# go
export PATH="$HOME/go/bin:$PATH"

. "$HOME/.cargo/env"
