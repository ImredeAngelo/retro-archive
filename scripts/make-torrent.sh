#!/bin/sh
for f in *.iso.* ; do 
	transmission-create -t "http://tracker.localhost:1337" -t "http://localhost:6969" -o "$f.torrent" "$f"
done