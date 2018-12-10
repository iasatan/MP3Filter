#!/bin/bash

basedir=$1

function containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

function google {
	xdg-open "http://www.google.com/search?q=%20$1"
	read delete
	if [[ "$delete" == "y" ]]; then
		echo "$1" >> "$basedir"/MP3Library/artists.txt
		echo "$1" >> /tmp/tempBadArtists.txt 	
	fi
	echo "$1" >> "$basedir"/MP3Library/everyArtist.txt

}

function store {
	echo "$1" >> "$basedir"/MP3Library/artists.txt
	echo "$1" >> /tmp/tempBadArtists.txt
	echo "$1"  >> "$basedir"/MP3Library/everyArtist.txt
}

function add {
	artist="$1"
	echo "$artist"
	echo "y for search, s for split, a for add"
	read userInput
	if [[ "$userInput" == "y" ]]; then
		google "$artist"
	elif [[ "$userInput" == "s" ]]; then
		readarray -td, a <<<"$artist"; declare -p a;
		for artistName in "${a[@]}"
		do
			artistName=$(echo "$artistName" | xargs)
			artistName=$(echo "$artistName" | tr -d '\n')
			if [[ $(check "$artistName") -eq 1 ]]; then
				echo "$artistName"
				echo "y for search, a for add"
				read userInput
				if [[ "$userInput" == "y" ]]; then
					google "$artistName"
				elif [[ "$userInput" == "a" ]]; then
					store "$artistName"
				else
					echo "$artistName"  >> "$basedir"/MP3Library/everyArtist.txt
				fi
			fi
		done
		echo "$artist"  >> "$basedir"/MP3Library/everyArtist.txt
	elif [[ "$userInput" == "a" ]]; then
		store "$artist"
	elif [[ "$userInput" == "x" ]]; then
		echo ""
	else
		echo "$artist"  >> "$basedir"/MP3Library/everyArtist.txt
	fi
}


function check {
	grep -q "$artist" "$basedir"/MP3Library/everyArtist.txt ; echo $?	
}

function iterate {
	for f in "."/*
	do
		if [[ -d "$f" ]]; then
			cd "$f"
			iterate
			cd ..
		elif [[ -f "$f" ]]; then
			artist=$(mp3infov2 -p %a "$f")
			if [[ $(check "$artist") -eq 1 ]]; then
				add "$artist"
			fi
		fi
	done
}

iterate

