#!/bin/sh
for f in *.iso.* ; do 
	if [[ $f != *.torrent ]]
	then
		transmission-create -t "http://tracker.localhost:1337" -o "$f.torrent" "$f"
		transmission-remote -a "$f.torrent"
	fi
done
#transmission-remote -a /var/lib/transmission-daemon/downloads/*.torrent