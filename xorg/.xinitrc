# fix the backslash/bar key
xmodmap -e "keycode 94 = backslash bar"

# map caps lock to control
xmodmap -e "keycode 66 = Control_L"
xmodmap -e "clear Lock"
xmodmap -e "add Control = Control_L"

# load all them xresources
xrdb -load /home/dylan/.Xresources

# turn off DPMS
xset -dpms; xset s off

# start redshift-gtk (enabling it doesn't work because it needs to be started after X, but X isn't autostarted)
systemctl --user start redshift-gtk

# launch the ol' wm
exec i3
