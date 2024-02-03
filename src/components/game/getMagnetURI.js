export default function getMagnetURI(hash, name, source, ...trackers) {
	let uri = `magnet:?xt=urn:btih:${hash}&dn=${name}&xs=${encodeURIComponent(source)}`;
	for (let i = 0; i < trackers.length; i++)
		uri += '&tr=' + encodeURIComponent(trackers[i])
	return uri;
}