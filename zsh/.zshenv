# add ~/scripts to PATH
export PATH='/usr/local/bin:/usr/bin:/home/dylan/scripts:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl'

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

