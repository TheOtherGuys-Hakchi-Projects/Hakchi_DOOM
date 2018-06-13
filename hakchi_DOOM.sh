#!/bin/sh

source /etc/preinit
script_init

WorkingDir=$(pwd)
GameName=$(echo $WorkingDir | awk -F/ '{print $NF}')
ok=0

if [ -f "/usr/share/games/$GameName/$GameName.desktop" ]; then
	DOOMTrueDir=$(grep /usr/share/games/$GameName/$GameName.desktop -e 'Exec=' | awk '{print $2}' | sed 's/\([/\t]\+[^/\t]*\)\{1\}$//')
	DOOMPortableCore="$DOOMTrueDir/etc/libretro/core/prboom"
	DOOMPortableFiles="$DOOMTrueDir/DOOM_1_files"
	wad=$(ls $DOOMPortableFiles | grep -i doom.wad)
	[ -z "$wad" ] && wad=$(ls $DOOMPortableFiles | grep -i doom1.wad)
	[ ! -z "$wad" ] && ok=1
fi

if [ "$ok" == 1 ]; then
	decodepng "$DOOMTrueDir/Hakchi_DOOM_assets/doom1splash-min.png" > /dev/fb0;
	exec retroarch-clover "../../..$DOOMPortableCore" "$DOOMPortableFiles/$wad" --custom-loadscreen "../../../../../../..$DOOMTrueDir/Hakchi_DOOM_assets/doom1splash-min.png"
else
	decodepng "$DOOMTrueDir/Hakchi_DOOM_assets/doomerror_files-min.png" > /dev/fb0;
	sleep 5
fi
