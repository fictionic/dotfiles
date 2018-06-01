# this file is sourced when zsh is interactive

HISTFILE=~/.zshhist
HISTSIZE=1000
SAVEHIST=1000

# disable flow control
stty -ixon -ixoff

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

# set up fzf zsh integration
[ -f "/usr/local/opt/fzf/shell/key-bindings.zsh" ] && source "/usr/local/opt/fzf/shell/key-bindings.zsh"
# unbind Alt-C from fzf-cd-widget; # rebind it to Ctrl-G ("go")
bindkey -r '\ec'; bindkey '^G' fzf-cd-widget
export FZF_ALT_C_COMMAND='rg --files | xargs dirname | unique'
# unbind Ctrl-T from fzf-cd-widget; # rebind it to Ctrl-F ("find")
bindkey -r '^T'; bindkey '^F' fzf-file-widget
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# set up 'z' command
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
# don't automatically resolve symlinks
export _Z_NO_RESOLVE_SYMLINKS=1

# set up 'fuck' command
eval $(thefuck --alias)
alias dammit=fuck
alias shit=fuck
alias yaourt=pacaur # cuz thefuck uses yaourt for pacman fixes

# redfin stuff
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
