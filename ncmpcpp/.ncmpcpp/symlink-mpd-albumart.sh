#!/bin/sh
cp -L -f -s "$(get-mpd-albumart.sh)" "/tmp/mpd-cover.jpg" 2>&1 >/dev/null
