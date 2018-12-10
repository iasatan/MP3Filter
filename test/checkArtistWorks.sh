#!/bin/bash

basedir=$1

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
    echo "y for search, a for add"
	read check
	if [[ "$check" == "y" ]]; then
		google "$artist"
	#elif [[ "$check" == "s" ]]; then
	#		readarray -td, a <<<"$artist"; declare -p a;
	#		for artistName in "${a[@]}"
	#		do
	#			if [[ $(check "$artistName") -eq 1 ]]; then
	#				add "$artistName"
	#			fi
	#		done
	#		echo "$artist"  >> "$basedir"/MP3Library/everyArtist.txt
	elif [[ "$check" == "a" ]]; then
		store "$artist"
	else
		echo "$artist"  >> "$basedir"/MP3Library/everyArtist.txt
    fi
}


function check {
	#artist=$(mp3infov2 -p %a "$1")
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

