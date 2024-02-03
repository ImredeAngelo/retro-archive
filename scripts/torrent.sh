#!/bin/sh
for f in *.iso.* ; do 
	if [[ $f != *.torrent ]]
	then
		transmission-create -t "http://tracker.localhost:1337/announce" -t "http://localhost:1337/announce" -o "$f.torrent" "$f"
		transmission-remote -a "$f.torrent"
		chmod 777 "$f.torrent"
	fi
done
#transmission-remote -a /var/lib/transmission-daemon/downloads/*.torrent