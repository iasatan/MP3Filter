#!/bin/bash
function delete {
	artist=$(mp3infov2 -p %a "$@")
	echo "removed bad artist" "$artist"
	rm -f "$@"
}
function check {
	artist=$(mp3infov2 -p %a "$1")
	artist=$(echo "$artist" | tr '[:upper:]' '[:lower:]' | awk -F '.feat' '{print $1}')
	grep -qx "$artist" /tmp/tempBadArtists.txt ; echo $?	
}
function iterate {
	for f in "."/*
	 do
		if [[ -d "$f" ]]; then
			cd "$f"
			iterate
			cd ..
		elif [[ -f "$f" ]]; then
			if [[ $(check "$f") -eq 0 ]]; then
					delete "$f"
				fi
		fi
	done
}
iterate
