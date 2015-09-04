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

#-----------------#
#  SET VARIABLES  #
#-----------------#
# first, add ~/scripts and ~/bin to PATH
# If user ID is greater than or equal to 1000 & if ~/$dir exists and is a directory & if ~/$dir is not already in your $PATH
# then export ~/$dir to your $PATH.
# finally, manually add some other variables, like the default console text editor
for dir in bin scripts; do
	if [[ $UID -ge 1000 && -d $HOME/$dir && -z $(echo $PATH | grep -o $HOME/$dir) ]]
	then
		export PATH=$HOME/$dir:${PATH}
	fi
	export XDG_CONFIG_HOME=/home/dylan/.config
	export XDG_DATA_HOME=/home/dylan/.local/share
	export VISUAL=vim
	export PAGER="less -R"
	##: colors in less :##
	#	blink
	export LESS_TERMCAP_mb=$(tput blink)
	#	bold		--> bold, white
	export LESS_TERMCAP_md=$(tput bold; tput setaf 15)
	#	stop bold, blink, underline
	export LESS_TERMCAP_me=$(tput sgr0)
	#	standout	--> bold, reverse colors
	export LESS_TERMCAP_so=$(tput bold; tput rev)
	#	stop standout, bold, blink, underline
	export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
	#	underline	--> underline, light blue
	export LESS_TERMCAP_us=$(tput smul; tput setaf 6)
	#	stop underline	--> stop bold, blink, underline
	export LESS_TERMCAP_ue=$(tput sgr0)
	#	reverse fb/bg colors
	export LESS_TERMCAP_mr=$(tput rev)
	#	dim text
	export LESS_TERMCAP_mh=$(tput dim)
	#	(I don't know what these do)
	export LESS_TERMCAP_ZN=$(tput ssubm)
	export LESS_TERMCAP_ZV=$(tput rsubm)
	export LESS_TERMCAP_ZO=$(tput ssupm)
	export LESS_TERMCAP_ZW=$(tput rsupm)
done

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
alias hdmi='xrandr --output HDMI2 --mode 1920x1080'
pacclean() {
	toremove=($(yaourt -Qqdt))
	if [[ ${#toremove[@]} == 0 ]]; then
		echo "Package database clean."
	else
		yaourt -Rns "${toremove[@]}"
	fi
}
restartnetctl() {
	sudo netctl restart "$(sudo netctl list | grep \* | sed $'s/* //')"
}
