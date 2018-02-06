# this file is sourced when zsh is interactive

HISTFILE=~/.zshhist
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory completealiases HIST_IGNORE_DUPS RC_QUOTES
unsetopt autocd beep extendedglob notify FLOW_CONTROL

# SET PROMPT
source ~/.zshprompt

# SET COLORS
source ~/.zshcolors

# CONFIGURE COMPLETION
source ~/.zshcompletion

# SET KEYBINDINGS
source ~/.zshkeys

# SET ALIASES
source ~/.zshalias

# ENABLE "HELP" COMMAND
autoload -U run-help
autoload run-help-git
autoload run-help-svn

# -----------------------------   MISCELANEOUS   ------------------------------

# make scrolling up and down only scroll through commands that match the currently typed command
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

# set up 'z' command
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# set up 'fuck' command
eval $(thefuck --alias)
alias dammit=fuck
alias shit=fuck
alias yaourt=pacaur # cuz thefuck uses yaourt for pacman fixes

# # ZPLUG
# source /usr/share/zsh/scripts/zplug/init.zsh
# zplug "changyuheng/fz" # fzf combined with z
# zplug load
# (zplug slows down startup quite noticably)

# set up fzf zsh integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# unbind Alt-C from fzf-cd-widget; # rebind it to Ctrl-G ("go")
bindkey -r '\ec'; bindkey '^G' fzf-cd-widget
# unbind Ctrl-T from fzf-cd-widget; # rebind it to Ctrl-F ("find")
bindkey -r '^T'; bindkey '^F' fzf-file-widget
