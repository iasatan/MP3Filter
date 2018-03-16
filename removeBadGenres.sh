#!/bin/bash

function delete {
	genre=$(mp3infov2 -p %g "$@")
	if ! [[ -z "$genre" ]]; then
		echo "$@ with bad genre $genre deleted"
		rm -f "$@"
	fi
}
function check {
	genre=$(mp3infov2 -p %g "$1")
	genre=$(echo "$genre" | tr '[:upper:]' '[:lower:]' | tr -dc '[:alpha:]')
    return $(grep -ci "$genre" /home/iasatan/Downloads/MP3Filter/badGenres.txt)
}

function iterate {
	for f in "."/*
		do
			if [[ -d "$f" ]]; then
				cd "$f"
				iterate
				cd ..
			elif [[ -f "$f" ]]; then
					check "$f" || delete "$f"
			fi
		done
}
iterate
