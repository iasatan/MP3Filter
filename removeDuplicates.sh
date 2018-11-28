#!/bin/bash

basedir=$1

function add {
	artist=$(mp3infov2 -p %a "$1")
	title=$(mp3infov2 -p %t "$1")
	 if [[ "$artist" == *"Various"* ]]; then
	 	 if [[ "$title" == *" - "* ]]; then
	 	 	IFS="-" read -a music <<< "$title"
	 	 	artist="${music[0]}"
	 	 	title="${music[1]}"
	 	 fi
	 fi
	artist=$(echo "$artist" | tr '[:upper:]' '[:lower:]' | tr -dc '[:alpha:]')
	title=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr -dc '[:alpha:]')
	echo "$title"  >> "$basedir"/MP3Library/Music/"$artist".txt
}

function delete {
	artist=$(mp3infov2 -p %a "$@")
	if ! [[ -z "$artist" ]]; then
		echo "$@ duplicate deleted"
		rm -f "$@"
	fi
}

function check {
	artist=$(mp3infov2 -p %a "$1")
	title=$(mp3infov2 -p %t "$1")
	artist=$(echo "$artist" | tr '[:upper:]' '[:lower:]' | tr -dc '[:alpha:]')
	title=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr -dc '[:alpha:]')
	echo $(grep -c "$title" "$basedir"/MP3Library/Music/"$artist".txt)
}

function iterate {
	for f in "."/*
		do
			if [[ -d "$f" ]]; then
				cd "$f"
				iterate
				cd ..
			elif [[ -f "$f" ]]; then
				if [[ $(check "$f") -gt 0 ]]; then
					delete "$f"
				else 
					add "$f"
				fi
			fi
		done
}
iterate
