#!/bin/bash
# find cover image
file="$(mpc current -f %file%)"
dir="/home/dylan/audio/library/hi-res/$(dirname "$file")"
# see if dir ends in "Disc N"
dirname="$(basename "$dir" | tr '[:upper:]' '[:lower:]')"
case $dirname in
	disc* | disk* | cd* | dvd*)
		dir="$(realpath "$dir/..")"
		;;
	*)
		;;
esac
# find an image with a promising name
img="$(find -H "$dir" -iname 'cover.jpg' | head -1)"
if [[ -z "$img" ]]; then
	# if no common album art file names are present, take what you can get
	img="$(find -H "$dir" -iname '*.jpg' | head -1)"
fi
# see what we got
if [[ -z "$img" ]]; then
	# remove old symlink
	rm "/tmp/mpd-cover.jpg" 2>&1 >/dev/null
else
	# symlink to /tmp
	cp -L -s "$img" "/tmp/mpd-cover.jpg" 2>&1 >/dev/null
fi
