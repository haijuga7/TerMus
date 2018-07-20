#!/data/data/com.termux/files/usr/bin/bash
# TerMus [ Termux Music ]
# Version: 1.2-beta
# Editor: Mr.A_S
# Github: https://github.com/haijuga7/
# tinggal pake apa susahnya.

g="\e[1;32m"
gt="\e[0;32m"
p="\e[1;37m"
kt="\e[0;33m"
merah="\033[31;1m"
biru="\033[36;1m"
ungu="\e[34;1m"

export DIR="/storage/sdcard0/Music"

banner() {
	echo -e "${ungu}
....................................................................
.....########.########.########..##.....##.##.....##..######........
........##....##.......##.....##.###...###.##.....##.##....##.......
........##....##.......##.....##.####.####.##.....##.##.............
........##....######...########..##.###.##.##.....##..######........
........##....##.......##...##...##.....##.##.....##.......##.......
........##....##.......##....##..##.....##.##.....##.##....##.......
........##....########.##.....##.##.....##..#######...######........
.................... ${p}Termux Music ~ v1.2beta${ungu} .......................

${ungu}[${p}+${ungu}] ${g}Directory :${p} $DIR\n"
}

loop=true
banner
while $loop; do
	trap '' 2
	read -p "    Music > " cmd
	echo
	if [ "$cmd" = "help" ]; then
		sleep 0.3
		clear
		banner
		echo -e "${merah}[${p}!${merah}] ${g}List of commands ${p}:\n
    ${ungu}> ${g}list           ${p}Show playlist
    ${ungu}> ${g}play <number>  ${p}Play music
    ${ungu}> ${g}play all       ${p}Play all music on playlist
    ${ungu}> ${g}chdir <path>   ${p}Change playlist directory 
                     ${g}(${ungu}current ${g}: ${p}$DIR${g})
    ${ungu}> ${g}clear          ${p}Clean cache
    ${ungu}> ${g}help           ${p}Show this help
    ${ungu}> ${g}exit           ${p}Exit from this program\n"
	elif [ "$cmd" = "list" ]; then
		sleep 0.3
		clear
		banner
		getlist=$(ls $DIR | grep mp3)
		replace=${getlist// /%%}
		n=1
		echo -e "${ungu}[${p}+${ungu}] ${g}Playlist ${p}:\n"
		for music in $replace; do
			echo -e "    ${merah}[${p}$n${merah}] ${g}${music//%%/ }"
			((n++))
		done
		echo -e "${p}"
	elif echo "$cmd" | grep -q "play"; then
		arg=$(echo "$cmd" | cut -d " " -f 2)
		getlist=$(ls $DIR | grep mp3)
		replace=${getlist// /%%}
		list=()
		for m in $replace; do
			list+=("$m")
		done
		if [ $arg = "all" ]; then
			for ms in $replace; do
				trap 'break' 2
				mpv "$DIR/${ms//%%/ }"
			done
		else
			music=${list[(($arg-1))]}
			mpv "$DIR/${music//%%/ }"
		fi
	elif echo "$cmd" | grep -q "chdir"; then
		export DIR="$(echo "$cmd" | cut -d " " -f 2)"
		echo "   ${ungu} [${p}+${ungu}] ${g}Directory changed ${p}!"
		sleep 2
		clear
		banner
	elif [ "$cmd" = "clear" ]; then
		clear
		banner
	elif [ "$cmd" = "exit" ]; then
		loop=false
	else
		echo "    ${merah}[${p}!${merah}] ${g}Wrong Input. Please check help ${p}!"
	fi
done
