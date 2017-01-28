# (this file is sourced by every zsh instance)

setopt nullglob RE_MATCH_PCRE

export XDG_CONFIG_HOME=/home/dylan/.config
export XDG_DATA_HOME=/home/dylan/.local/share
export SHELL=zsh
export EDITOR="vim"
export VISUAL=$EDITOR
export TERMCMD="termite"
export PAGER="less -R"
# set vim as manpager
export MANPAGER="/usr/bin/vimpager"
# ssh-agent stuff
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
