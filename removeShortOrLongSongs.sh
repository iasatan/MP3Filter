#!/bin/bash
function delete {
	echo "$@"" deleted"
	rm -f "$@"
}
function iterate {
	for f in "."/*
		do
			if [[ -d "$f" ]]; then
				cd "$f"
				iterate
				cd ..
			elif [[ -f "$f" ]]; then
                local lenght=$(mp3info -p %S "$f")
				#echo "$lenght"
				if [[ "$lenght" -lt 150 || "$lenght" -gt 300 ]]; then
                    delete "$f"
                fi
			fi
		done
}
iterate
