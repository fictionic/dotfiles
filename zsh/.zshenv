# (this file is sourced by every zsh instance)

setopt nullglob RE_MATCH_PCRE

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export SHELL="$(which zsh)" # breaks pipenv without full path
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
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --glob "!.git/*" 2>/dev/null'
# ripgrep config
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"
