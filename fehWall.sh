#!/bin/sh
while true; do
  #wallpaper=`find ~/fehWallRotation -maxdepth 1 -type f \( -name '*.jpg' -o -name '*.png' \) -print0 |shuf -n1 -z`
  wallpaper=`find ~/images/wallpaper -maxdepth 1 -type f \( -name '*.jpg' -o -name '*.png' \) -print0 |shuf -n1 -z`
  feh --bg-scale "$wallpaper"
  echo "current wallpaper $wallpaper"
	sleep 10s
done
