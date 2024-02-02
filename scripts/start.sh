#!/bin/sh
transmission-daemon --config-dir /etc/transmission-daemon/
transmission-remote -a /var/lib/transmission-daemon/downloads*.torrent
./opentracker