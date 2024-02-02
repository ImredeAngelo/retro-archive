import getCoverFromSerial from './getCoverFromSerial'
import './game.css'

export function Game(props) {
	const resource = "../../lib/playstation-2/files"
	const serial = "SCUS-97472"

	// P2P - BitTorrent
	const tracker = '&tr=http%3A%2F%2Flocalhost%3A6969%2Fannounce'
	const magnetURI = 'magnet:?xt=urn:btih:39bcbcbc273551854105d3e6757254c55d920a5c&dn=SCUS-97472.iso' + tracker

	return (
		<div class="wrapper">
			<div class="cover">
				<img class="image" src={getCoverFromSerial(serial, false)}/>
			</div>
			
			<h1>Shadow of the Colossus</h1>
			<div class="card">
				{/* <button onClick={() => setCount((count) => count + 1)}>
					count is {count}!
				</button> */}
				<div class="list">
					<button>
						<a href={`${resource}/${serial}.iso`} download="Shadow of the Colossus (USA).iso">
							Download with Browser
						</a>
					</button>
					<button>
						<a href={magnetURI}>
							Download with Torrent (Magnet URI)
						</a>
					</button>
					<button>
						<a href={`${resource}/${serial}.torrent`} download={`${serial}.torrent`}>
							Download torrent file
						</a>
					</button>
				</div>
				<p>
					Shadow of the Colossus is a rather difficult game to review for a couple very important reasons. 
					First, it's hard to talk about the game without spoiling anything, something I'm going to attempt to avoid doing as much as possible. 
					Secondly, trying to describe exactly what makes Shadow of the Colossus so fantastic is akin to trying to describe why the bodies of work of Picasso, 
					Bach or Beethoven are unquestioned classics; you can do your best, 
					but any of these examples must be experienced in full to truly be understood, and especially appreciated.
				</p>
			</div>
			{/* <p class="read-the-docs">
				Click on the Vite and Preact logos to learn more
			</p> */}
		</div>
	)
}
