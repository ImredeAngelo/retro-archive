FROM nginx:1.25.3-alpine
EXPOSE 80

COPY start.sh /usr/bin/start.sh
RUN apk --no-cache update

# Set up torrent seeding (transmission)
RUN apk add transmission transmission-cli transmission-daemon
COPY ./config/transmission.json /etc/transmission-daemon/settings.json
COPY ./games /var/lib/transmission-daemon/downloads

EXPOSE 51413

# Make torrents
WORKDIR /var/lib/transmission-daemon/downloads
COPY ./make-torrents.sh ./
RUN ./make-torrents.sh

# Set up tracker (opentracker)
WORKDIR /var/lib
RUN apk add cvs git g++ make curl-dev
RUN cvs -d :pserver:cvs@cvs.fefe.de:/cvs -z9 co libowfat
RUN git clone git://erdgeist.org/opentracker
WORKDIR /var/lib/libowfat
RUN make
WORKDIR /var/lib/opentracker
RUN make

EXPOSE 6969

# Set up reverse proxy (Nginx)
COPY ./config/nginx.conf /etc/nginx

# Set up website
# WORKDIR /usr/app
# ln -s /var/lib/transmission-daemon /usr/app/src/games
# COPY src .
# COPY public .
# COPY package.json .
# COPY index.html .
# COPY vite.config.js .
# RUN yarn
# RUN 

# Start
CMD [ "/usr/bin/start.sh" ]
