#!/bin/bash

function add {
	artist=$(mp3infov2 -p %a "$1")
	echo "$artist"
	echo "$artist"  >> /home/iasatan/Downloads/MP3Filter/everyArtist.txt
    xdg-open "http://www.google.com/search?q=%20$artist"

}

function check {
	artist=$(mp3infov2 -p %a "$1")
	grep -q "$artist" /home/iasatan/Downloads/MP3Filter/everyArtist.txt ; echo $?	
}

function iterate {
	for f in "."/*
		do
			if [[ -d "$f" ]]; then
				cd "$f"
				iterate
				cd ..
			elif [[ -f "$f" ]]; then
				if [[ $(check "$f") -eq 1 ]]; then
					add "$f"
				fi
			fi
		done
}
iterate
