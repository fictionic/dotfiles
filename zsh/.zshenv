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
# when running raw fzf, use fd instead of find
export FZF_DEFAULT_COMMAND='fd --type f'
# ripgrep config
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"

# ssh agent stuff
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

### redfin stuff
export HOMEBREW_GITHUB_API_TOKEN="1c0076d1e621a36ec6092f202fd614e388bf5e2a"
export REDFIN_MAIN=$HOME/code/main
eval "$(/home/dylan/code/fin/bin/fin init -)"
export PATH=~/bin:/usr/local/bin:~/code/scripts:$PATH
export CORVAIR_CONFIG="$HOME/.corvair-config.json"
# export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export MAVEN_OPTS="-Xmx2G -Xms1G -XX:ReservedCodeCacheSize=128m -XX:-MaxFDLimit"
export LD_LIBRARY_PATH="/usr/local/lib"
export REDFIN_LOG_SQL=true

source $HOME/.profile
