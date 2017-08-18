#!/bin/bash
dir=
img=
# find cover image
file="$(mpc current -f %file%)"
dir=/home/dylan/audio/library/hi-res/"$(dirname "$file")"
# TODO: see if dir ends in "Disc N", use `find` from parent if so
for file in $dir{cover,front}.jpg; do
	if [ -f "$file" ]; then
		img=$dir/$file
	fi
done
# if no common album art file names are present, take what you can get
if [ ! "$img" ]; then
	img="$(find -H "$dir" -name '*.jpg' | head -1)"
fi
if [[ -z "$img" ]]; then
	exit
fi
# check if the file is the same
if [[ $(stat -c %i "$img") != $(stat -c %i "/tmp/mpd-cover.jpg") ]]; then
	cp "$img" "/tmp/mpd-cover.jpg"
fi
