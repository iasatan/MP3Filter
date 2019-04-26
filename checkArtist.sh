#!/bin/bash

basedir=$1

#The exit status is 0 (true) if the pattern was found;
#The exit status is 1 (false) if the pattern was not found.
function check {
	artist=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	grep -qx "$artist" "$basedir"/MP3Library/everyArtist.txt ; echo $?	
}
function checkBad {
	artist=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	grep -qx "$artist" "$basedir"/MP3Library/artists.txt ; echo $?	
}
function checkNewBad {
	artist=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	grep -qx "$artist" /tmp/tempBadArtists.txt ; echo $?	
}

function containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

function google {
	xdg-open "http://www.google.com/search?q=%20$1"
	echo ""
	read -n1 delete
	echo ""
	artist=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	if [[ "$delete" == "y" ]]; then
		echo "$artist" >> "$basedir"/MP3Library/artists.txt
		echo "$artist" >> /tmp/tempBadArtists.txt 	
	fi
	echo "$artist" >> "$basedir"/MP3Library/everyArtist.txt

}

function store {
	artist=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	echo "$artist" >> "$basedir"/MP3Library/artists.txt
	echo "$artist" >> /tmp/tempBadArtists.txt
	echo "$artist"  >> "$basedir"/MP3Library/everyArtist.txt
}

function checkBadArray {
	readarray -td, a <<<"$1"; declare -p a;
	for artistName in "${a[@]}"
	do
		artistName=$(echo "$artistName" | xargs)
		artistName=$(echo "$artistName" | tr -d '\n')
		if [[ $(checkBad "$artistName") -eq 0 ]]; then
			store "$1"
			echo "bad artists: $artistName ........."
			break
		fi
		if [[ $(checkNewBad "$artistName") -eq 0 ]]; then
			store "$1"
			echo "bad artists: $artistName ........."
			break
		fi
	done
}

function arrayArtists {
	artist=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	checkBadArray "${artist}"
	readarray -td, a <<<"$artist"; declare -p a;
	for artistName in "${a[@]}"
	do
		artistName=$(echo "$artistName" | xargs)
		artistName=$(echo "$artistName" | tr -d '\n')
		if [[ $(check "$artistName") -eq 1 ]]; then
			echo "$artistName"
			echo "y for search, a for add"
			read -n1 userInput
			echo ""
			if [[ "$userInput" == "y" ]]; then
				google "$artistName"
			elif [[ "$userInput" == "a" ]]; then
				store "$artistName"
			else
				artistName=$(echo "$artistName" | tr '[:upper:]' '[:lower:]')
				echo "$artistName"  >> "$basedir"/MP3Library/everyArtist.txt
			fi
		fi
	done
	checkBadArray "${artist}"
	echo "$artist"  >> "$basedir"/MP3Library/everyArtist.txt
}
function add {
	artist="$1"
	echo "$artist"
	if [[ "$artist" == *,* ]]; then
		arrayArtists "$artist"
	else
		echo "y for search, s for split, a for add"
		read -n1 userInput
		echo ""
		if [[ "$userInput" == "y" ]]; then
			google "$artist"
		#elif [[ "$userInput" == "s" ]]; then
		#	arrayArtists "$artist"		
		elif [[ "$userInput" == "a" ]]; then
			store "$artist"
		elif [[ "$userInput" == "x" ]]; then
			echo ""
		else
			artist=$(echo "$artist" | tr '[:upper:]' '[:lower:]')
			echo "$artist"  >> "$basedir"/MP3Library/everyArtist.txt
		fi
	fi
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
			artist=$(echo "$artist" | awk -F '.feat' '{print $1}')
			artist=$(tr ';' ',' <<<"$artist")
			artist=$(tr '&' ";" <<<"$artist")
			
			if [[ $(check "$artist") -eq 1 ]]; then
				add "$artist"
			fi
		fi
	done
}

iterate

