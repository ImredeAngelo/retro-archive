# =======
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



# =======
# Set up bittorrent client and reverse proxy
FROM nginx:1.25.3-alpine AS server

# Set up torrent seeding (transmission)
RUN apk --no-cache update
RUN apk add transmission transmission-cli transmission-daemon
COPY config/transmission.json /etc/transmission-daemon/settings.json
RUN mkdir -p /var/lib/transmission-daemon/games

EXPOSE 9091 51413

# Start services
COPY scripts/torrent.sh /usr/local/bin/torrent.sh
COPY scripts/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/torrent.sh
RUN chmod +x /usr/local/bin/start.sh
ENTRYPOINT [ "start.sh" ]



# =======
# Build web app
FROM node:21-alpine AS production

WORKDIR /usr/app
COPY public public
COPY src src
ADD index.html .
ADD package.json .
ADD vite.config.js .
ADD yarn.lock .
RUN yarn 
RUN yarn build

# For development
# CMD [ "yarn", "dev", "--host" ]
# EXPOSE 3000



# =======
# Final build stage
FROM server

# Get tracker and web app from previous stages
COPY --from=tracker /var/lib/opentracker /var/lib/opentracker
COPY --from=production /usr/app/dist /etc/nginx/data

# Configure Nginx
WORKDIR /etc/nginx
COPY ./config/app.conf ./conf.d/default.conf
EXPOSE 80
