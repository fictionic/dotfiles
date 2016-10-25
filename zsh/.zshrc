HISTFILE=~/.zshhist
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory nomatch nullglob completealiases HIST_IGNORE_DUPS
unsetopt autocd beep extendedglob notify

# SET ENVIRONMENT
source ~/.zshenv

# SET PROMPT
source ~/.zshprompt

# SET COLORS
source ~/.zshcolors

# ENABLE COMPLETION
source ~/.zshcompletion

# SET KEYBINDINGS
source ~/.zshkeys

# SET ALIASES
source ~/.zshalias

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

# set up 'z' command
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
