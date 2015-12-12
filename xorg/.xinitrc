# map the proper things to the backslash/pipe key
xmodmap -e "keycode 94 = backslash bar"

# load all them xresources
xrdb -load /home/dylan/.Xresources

# turn off DPMS
xset -dpms; xset s off

# start up all them daemons
xbindkeys
syndaemon -d -i .4 -K

# launch the ol' wm
exec i3
