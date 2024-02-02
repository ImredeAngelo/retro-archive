export default function getCoverFromSerial(serial, useDefault = true) {
	const [url, filetype] = useDefault ? ['default', 'jpg'] : ['3d', 'png'];
	return `https://raw.githubusercontent.com/xlenore/ps2-covers/main/covers/${url}/${serial}.${filetype}`;
}