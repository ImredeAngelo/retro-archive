import getCoverFromSerial from './getCoverFromSerial'
import getMagnetURI from './getMagnetURI'
import './game.css'

import db from "../../roms.json"

export function Game(props) {
	const game = db[0];
	const resource = "../../../games"
	const filename = game.serial + ".iso.gz"
	
	// P2P - BitTorrent
	const hash = '4f7367e1b693ac9e253c627708431ca1f5947e30'
	const magnetURI = getMagnetURI(hash, filename, "http://localhost/games/" + filename, "http://tracker.localhost:1337/announce", "http://localhost:1337/announce");
	
	return (
		<div class="wrapper">
			<div class="cover">
				<img class="image" src={getCoverFromSerial(game.serial, false)}/>
			</div>
			
			<h1>{ game.name }</h1>
			<div class="card">
				<div class="list">
					<button>
						<a href={`${resource}/${filename}`} download={`${ game.name } (USA).iso.gz`}>
							Download with Browser
						</a>
					</button>
					<button>
						<a href={magnetURI}>
							Download with Torrent (Magnet URI)
						</a>
					</button>
					<button>
						<a href={`${resource}/${filename}.torrent`} download={`${ game.name } (USA).iso.gz.torrent`}>
							Download torrent file
						</a>
					</button>
				</div>
				<p>
					{ game.description }
				</p>
			</div>
		</div>
	)
}
