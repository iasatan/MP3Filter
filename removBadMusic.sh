#!/bin/bash

function deleteSong {
	rm -f "$@"
}

function checkLenghtofSong {
	local lenght=$(mp3info -p %S "$f")
	if [[ "$lenght" -lt 150 || "$lenght" -gt 300 ]]; then
		echo "$f""short of long song removed"
        delete "$f"
    fi
}

function getArtistName {
	local artist=$(mp3infov2 -p %a "$1")
	artist=$(echo "$artist" | tr '[:upper:]' '[:lower:]' | awk -F '.feat' '{print $1}')
	return artist
}
function getGenre {
	local genre=$(mp3infov2 -p %g "$1")
	genre=$(echo "$genre" | tr '[:upper:]' '[:lower:]' | tr -dc '[:alpha:]')
	return genre

}
function checkForBadArtist {
	local artist=$(getArtistName "$1")
	grep -qx "$artist" "$basedir"/MP3Library/artists.txt ; echo $?	
}
function checkForBadGenre {
	local genre=$(getGenre $1)
	grep -qx "$genre" "$basedir"/MP3Library/badGenres.txt ; echo $?
}
function checkMusic {
	local artist=$(mp3infov2 -p %a "$1")
	local genre=$(mp3infov2 -p %g "$@")
	if [[ $(checkForBadArtist "$1") -eq 0 ]]; then
		echo "removed bad artist" "$artist"
		delete "$1"
	fi
	if [[ $(checkForBadGenre "$1") -eq 0 ]]; then
		if ! [[ -z "$genre" ]]; then
			echo "$1 with bad genre $genre deleted"
			delete "$1"
		fi
	fi
}

function iterateThrougFiles {
	for f in "."/*
		do
			if [[ -d "$f" ]]; then
				cd "$f"
				iterateThrougFiles
				cd ..
			elif [[ -f "$f" ]]; then
				checkLenghtofSong "$f"
				checkMusic "$f"
			fi
		done
}
iterateThrougFiles
