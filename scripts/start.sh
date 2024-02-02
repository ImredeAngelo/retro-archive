#!/bin/sh
transmission-daemon --config-dir /etc/transmission-daemon/
(cd /var/lib/transmission-daemon/downloads ; echo "$PWD" && sh /usr/local/bin/torrent.sh)
./opentracker