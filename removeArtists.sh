#!/bin/bash
function delete {
	artist=$(mp3infov2 -p %a "$@")
	echo "removed bad artist" "$artist"
	rm -f "$@"
}
function check {
	artist=$(mp3infov2 -p %a "$1")
	return $(grep -cix "$artist" /home/iasatan/NonSynced/linuxScripts/mp3/artists.txt)
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
