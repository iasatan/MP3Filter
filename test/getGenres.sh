#!/bin/bash

function add {
	genre=$(mp3infov2 -p %g "$1")
	echo "$genre"  >> /home/iasatan/Downloads/MP3Filter/goodGenres.txt
}

function check {
	genre=$(mp3infov2 -p %g "$1")
	echo $(grep -c "$genre" /home/iasatan/Downloads/MP3Filter/goodGenres.txt)
}

function iterate {
	for f in "."/*
		do
			if [[ -d "$f" ]]; then
				cd "$f"
				iterate
				cd ..
			elif [[ -f "$f" ]]; then
				if [[ $(check "$f") -lt 1 ]]; then
					add "$f"
				fi
			fi
		done
}
iterate
