# (this file is sourced by every zsh instance)

setopt nullglob RE_MATCH_PCRE

export XDG_CONFIG_HOME="/home/dylan/.config"
export XDG_DATA_HOME="/home/dylan/.local/share"
export SHELL="/usr/bin/zsh" # breaks pipenv without full path
export EDITOR="vim"
export VISUAL="$EDITOR"
export TERMCMD="termite"
export PAGER="vimpager"
export SYSTEMD_PAGER="less"
# set vim as manpager
export MANPAGER="$PAGER"
# ssh-agent stuff
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# when running raw fzf, use rg instead of find
export FZF_DEFAULT_COMMAND='rg --files --no-follow --glob "!.git/*"'
# ripgrep config
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"
