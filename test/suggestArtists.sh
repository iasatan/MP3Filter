#!/bin/bash

function iterate {
	for f in "."/*
	do
		if [[ -d "$f" ]]; then
			cd "$f"
			iterate
			cd ..
		elif [[ -f "$f" ]]; then
			artist=$(mp3infov2 -p %a "$f")
			echo "$artist" >> /tmp/artists.txt
		fi
	done
}
touch /tmp/artists.txt
iterate
sort -u /tmp/artists.txt >> /tmp/artists2.txt
rm /tmp/artists.txt
