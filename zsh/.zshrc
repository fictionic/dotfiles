# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' prompt 'Suggestions:'
zstyle :compinstall filename '/home/dylan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.zshhist
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory nomatch
unsetopt autocd beep extendedglob notify
bindkey -v
# End of lines configured by zsh-newuser-install

#--------------#
#  SET PROMPT  #
#--------------#
PROMPT="%n@%M:%~%(!.#.$) "

#-----------------#
#   KEYBINDINGS   #
#-----------------#
# make HOME work as it should
bindkey -v '[7~' vi-beginning-of-line
bindkey -a '[7~' vi-beginning-of-line
# make END work as it should
bindkey -v '[8~' vi-end-of-line
bindkey -a '[8~' vi-end-of-line
# make DEL work as it should
bindkey -v '[3~' delete-char
bindkey -a '[3~' delete-char
# make Ctrl+DEL work as it should
bindkey -v '[3;5~' delete-word
bindkey -a '[3;5~' delete-word
# make BKSP work as it should
bindkey -v '' backward-delete-char
# (don't want this to delete stuff in command mode though!)
# make Ctrl+BKSP work as it should
bindkey -v '' backward-delete-word
bindkey -a '' backward-delete-word
# make Ctrl+Left move one word backwards
bindkey -v 'Od' vi-backward-word
bindkey -a 'Od' vi-backward-word
# make Ctrl+Right move one word backwards
bindkey -v 'Oc' vi-forward-word
bindkey -a 'Oc' vi-forward-word
# make Underscore work properly
bindkey -a '_' vi-beginning-of-line
# make scrolling up and down only scroll through commands that match the currently typed command
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -v "^[[A" up-line-or-beginning-search # Up
bindkey -v "^[[B" down-line-or-beginning-search # Down

#------------------#
#   MISCELANEOUS   #
#------------------#
# ls colors
eval $(dircolors -b /home/dylan/.dircolors)
# give info about where to install packages containing commands that aren't currently installed
source /usr/share/doc/pkgfile/command-not-found.zsh

#-----------------#
#     ALIASES     #
#-----------------#

# let sudo take aliases as arguments
alias sudo='sudo '

# make "help" work as expected
autoload -U run-help
autoload run-help-git
autoload run-help-svn
unalias run-help
alias help=run-help

# make ls use colors, and be easier to access
alias ls='ls --color=auto'
alias ll='ls --color=auto -l'
alias la='ls --color=auto -a'
alias l='ls --color=auto'
alias s='ls --color=auto'

# misc...

alias 'sudo vim'='sudo -e'
alias xr='xrdb /home/dylan/.Xresources'
alias pgrep='ps -e | grep'
#alias less=vimpager
alias pingg='ping google.com'
alias uplinux='yaourt -Syu --devel --aur'
pacclean() {
	toremove="$(yaourt -Qqdt)"
	if [[ "$toremove" == '' ]]; then
		echo "Package database clean."
	else
		yaourt -R $toremove
	fi
}
restartnetctl() {
	sudo netctl restart "$(sudo netctl list | grep \* | sed $'s/* //')"
}
