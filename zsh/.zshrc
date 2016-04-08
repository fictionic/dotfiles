HISTFILE=~/.zshhist
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory nomatch completealiases HIST_IGNORE_DUPS
unsetopt autocd beep extendedglob notify

# set vi-style line editing
bindkey -v
export KEYTIMEOUT=1

# SET PROMPT
source ~/.zshprompt

# SET COLORS
source ~/.zshcolors

# ENABLE COMPLETION
source ~/.zshcompletion

# SET KEYBINDINGS
source ~/.zshkeys

#-----------------------------#
#  SET ENVIRONMENT VARIABLES  #
#-----------------------------#
# add ~/scripts to PATH
export PATH='/usr/bin:/usr/local/bin:/home/dylan/scripts:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl'
export XDG_CONFIG_HOME=/home/dylan/.config
export XDG_DATA_HOME=/home/dylan/.local/share
export SHELL=zsh
export VISUAL=vim
export EDITOR=vim
export TERMCMD="termite"
export PAGER="less -R"

# ENABLE "HELP" COMMAND
autoload -U run-help
autoload run-help-git
autoload run-help-svn

#------------------#
#   MISCELANEOUS   #
#------------------#
# give info about where to install packages containing commands that aren't currently installed
source /usr/share/doc/pkgfile/command-not-found.zsh
# make scrolling up and down only scroll through commands that match the currently typed command
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
