# (this file is sourced by every zsh instance)

setopt nullglob RE_MATCH_PCRE

export XDG_CONFIG_HOME="/Users/dylanforbes/.config"
export XDG_DATA_HOME="/Users/dylanforbes/.local/share"
export SHELL="zsh" # breaks pipenv without full path
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

### redfin stuff
export HOMEBREW_GITHUB_API_TOKEN="1c0076d1e621a36ec6092f202fd614e388bf5e2a"
export REDFIN_MAIN=$HOME/code/main
eval "$(/Users/dylanforbes/code/fin/bin/fin init -)"
export PATH=~/bin:/usr/local/bin:~/code/scripts:$PATH
export CORVAIR_CONFIG="$HOME/.corvair-config.json"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export MAVEN_OPTS="-Xmx2G -Xms1G -XX:ReservedCodeCacheSize=128m -XX:-MaxFDLimit"

# for 'too many open files' issue
ulimit -n 8000
eval "$($HOME/code/fin/bin/fin init -)"

# for java sql driver
export CLASSPATH=/usr/local/pgsql/lib/postgresql.jar:$CLASSPATH
