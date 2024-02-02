# Set up tracker (opentracker)
FROM alpine:3.18 AS tracker

WORKDIR /var/lib
RUN apk --no-cache update
RUN apk add cvs git g++ make curl-dev
RUN cvs -d :pserver:cvs@cvs.fefe.de:/cvs -z9 co libowfat
RUN git clone git://erdgeist.org/opentracker
WORKDIR /var/lib/libowfat
RUN make
WORKDIR /var/lib/opentracker
RUN make

EXPOSE 6969


# Set up bittorrent client and reverse proxy
FROM nginx:1.25.3-alpine AS server

# Get tracker from previous stage
COPY --from=tracker /var/lib/opentracker /var/lib/opentracker

# Set up torrent seeding (transmission)
RUN apk --no-cache update
RUN apk add transmission transmission-cli transmission-daemon
COPY config/transmission.json /etc/transmission-daemon/settings.json
RUN mkdir -p /var/lib/transmission-daemon/downloads

EXPOSE 51413

# Start services
COPY scripts/torrent.sh /usr/local/bin/torrent.sh
COPY scripts/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/torrent.sh
RUN chmod +x /usr/local/bin/start.sh
WORKDIR /var/lib/opentracker
ENTRYPOINT [ "start.sh" ]

# Frequently edited files
FROM server

# Configure Nginx
# COPY ./config/nginx.conf /etc/nginx
EXPOSE 80
