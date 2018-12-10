#!/bin/bash

basedir=$1

function add {
	artist=$(mp3infov2 -p %a "$1")
	echo "$artist"
	echo "$artist"  >> "$basedir"/MP3Library/everyArtist.txt
    xdg-open "http://www.google.com/search?q=%20$artist"
    read delete
    if [[ "$delete" == "y" ]]; then
    	echo "$artist" >> "$basedir"/MP3Library/artists.txt
    	echo "$artist" >> /tmp/tempBadArtists.txt
    	
    fi

}

function check {
	artist=$(mp3infov2 -p %a "$1")
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
				if [[ $(check "$f") -eq 1 ]]; then
					add "$f"
				fi
			fi
		done
}

iterate
#!/bin/bash

basedir=$1

function add {
	artist=$(mp3infov2 -p %a "$1")
	echo "$artist"
	echo "$artist"  >> "$basedir"/MP3Library/everyArtist.txt
    xdg-open "http://www.google.com/search?q=%20$artist"
    read delete
    if [[ "$delete" == "y" ]]; then
    	echo "$artist" >> "$basedir"/MP3Library/artists.txt
    	echo "$artist" >> /tmp/tempBadArtists.txt
    	
    fi

}

function check {
	artist=$(mp3infov2 -p %a "$1")
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
				if [[ $(check "$f") -eq 1 ]]; then
					add "$f"
				fi
			fi
		done
}

iterate
