#!/data/data/com.termux/files/usr/bin/bash
echo -n "checking mpv package... "
if mpv --version | grep -q "mpv/MPlayer/mplayer2"; then
	echo "ok"
else
	echo "err"
	echo "installing mpv... "
	apt install --force-yes mpv
	if mpv --version | grep -q "mpv/MPlayer/mplayer2"; then
		echo "mpv installed... "
	else
		echo "can't install mpv... exit"
		exit
	fi
fi
_path=$(echo $PATH | cut -d ":" -f 1)
echo "$ cp music.sh $_path/termus"
cp termus.sh $_path/termus
echo "$ chmod +x $_path/termux"
chmod +x $_path/termus
echo "$ termux-fix-shebang $_path/termus"
termux-fix-shebang $_path/termus
echo "> termu installed..."
echo "> type \"termus\" and enter to run..."
