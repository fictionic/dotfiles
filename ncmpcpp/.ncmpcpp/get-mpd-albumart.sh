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
img="$(find -H "$dir" -regextype posix-extended -iregex '.*/.*?(cover|folder|front)\.(jpg|png)' | head -1)"
if [[ -z "$img" ]]; then
	# look for something named after the album
	album="$(mpc current -f %album% | sed 's@/@,@g')"
	img="$(find -H "$dir" -iname "$album.jpg" | head -1)"
	if [[ -z "$img" ]]; then
		artist="$(mpc current -f %artist%)"
		img="$(find -H "$dir" -iname "$artist - $album.jpg" | head -1)"
		if [[ -z "$img" ]]; then
			# if no common album art file names are present, take what you can get
			img="$(find -H "$dir" -iname '*.jpg' | head -1)"
		fi
	fi
fi
# if there's nothing, use "no art found" image
if [[ -z "$img" ]]; then
	printf "/home/dylan/images/no_art_found.png"
	exit 1
fi
printf "$img"
exit 0
