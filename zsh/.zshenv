# (this file is sourced by every zsh instance)

setopt nullglob RE_MATCH_PCRE

export XDG_CONFIG_HOME="/Users/dylanforbes/.config"
export XDG_DATA_HOME="/Users/dylanforbes/.local/share"
export SHELL="/usr/bin/zsh" # breaks pipenv without full path
export EDITOR="vim"
export VISUAL="$EDITOR"
export TERMCMD="termite"
export PAGER="less"
export SYSTEMD_PAGER="less"
# set vim as manpager
export MANPAGER="$PAGER"
# ssh-agent stuff
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# when running raw fzf, use rg instead of find
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden --no-ignore --glob "!.git/*"'

export HOMEBREW_GITHUB_API_TOKEN="1c0076d1e621a36ec6092f202fd614e388bf5e2a"
