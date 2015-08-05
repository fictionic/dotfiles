#if [ $(uname -a) != $(uname -a | sed 's/ARCH//') ]; then
# we're on arch linux

# first, set environment variables
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
	export PAGER=vimpager

done

xmodmap -e "keycode 94 = backslash bar"
xrdb -load /home/dylan/.Xresources
#rm /home/dylan/.ncmpcpp/config
#ln -s /home/dylan/.ncmpcpp/config_archlinux /home/dylan/.ncmpcpp/config

# start up all them daemons
xbindkeys
mpd
syndaemon -d -i .5 -t -K
compton -b

# turn off automatic screen power off
xset -dpms; xset s off


# launch the ol' wm
exec i3

else
# we're on xubuntu (not sure this ever gets run, actually)
ln -s /home/dylan/.ncmpcpp/config_xubuntu /home/dylan/.ncmpcpp/config

fi
