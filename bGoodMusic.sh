#!/bin/bash

function add {
	artist=$(mp3infov2 -p %a "$1")
	title=$(mp3infov2 -p %t "$1")
	echo "$title"  >>/home/iasatan/NonSynced/linuxScripts/mp3/goodMusic/"$artist".txt
    echo "$title"
}

function iterate {
	for f in "."/*
		do
			if [[ -d "$f" ]]; then
				cd "$f"
				iterate
				cd ..
			elif [[ -f "$f" ]]; then
					add "$f"
			fi
		done
}
find . -type d -empty -delete -print
iterate
directory=${PWD##*/}
 echo "$directory" >> /home/iasatan/NonSynced/linuxScripts/mp3/storedGood.txt
