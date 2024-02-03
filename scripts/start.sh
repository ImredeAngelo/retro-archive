#!/bin/sh
nginx
transmission-daemon --config-dir /etc/transmission-daemon/
(cd /var/lib/transmission-daemon/games ; sh /usr/local/bin/torrent.sh)
(cd /var/lib/opentracker ; ./opentracker)