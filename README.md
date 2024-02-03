# Retro Archive
This site was created to gain experience with Peer-to-Peer (P2P) systems, mainly the BitTorrent protocol. While only intended for educational purposes, it does improve upon on the current retro gaming and emulation eco-system. In most places, downloading the disc images of an old game to run on an emulator is legal if you own a physical copy of the game, making emulation of childhood classics a fun hobby. However, the sites that archive old retro games have very limited bandwidth as are often overloaded. This site allows users to download ROM games directly from the website, or from a torrent. The website runs its own tracker and BitTorrent client, ensuring that the torrent will always be available.

![Image preview of site](preview.png)

## Usage
1. Save games as (compressed) .iso files in `/roms`
2. For each file, enter its metadata into `/src/roms.json`
3. Build and run the docker image, or run `yarn dev` for a dev environment
4. Profit

## Structure
The server runs [OpenTracker](https://erdgeist.org/arts/software/opentracker/) as a closed tracker, and [Transmission](https://transmissionbt.com/) as a BitTorrent client. The client is configured to be as altruistic as possible, seeding to everyone at maximal capacity. This combination ensures atleast 1 peer is seeding any game found on the website at any time, and that all peers are easily discovered by new clients. 

The web site is a simple Preact web app, using the entries from `/src/roms.json` to display games. In a production environment this file would instead be implemented as a database. The site is served by Nginx, which also acts a reverse proxy for the other services.

Finally, playstation 2 games with the correct serial number specified in `/src/roms.json` will automatically use cover images from `https://raw.githubusercontent.com/xlenore/ps2-covers`. Other consoles will not have any cover images unless the source code is modified.