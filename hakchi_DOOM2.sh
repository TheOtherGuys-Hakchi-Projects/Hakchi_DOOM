#!/bin/sh

source /etc/preinit
script_init

WorkingDir=$(pwd)
GameName=$(echo $WorkingDir | awk -F/ '{print $NF}')
ok=0

if [ -f "/usr/share/games/$GameName/$GameName.desktop" ]; then
	DOOMTrueDir=$(grep /usr/share/games/$GameName/$GameName.desktop -e 'Exec=' | awk '{print $2}' | sed 's/\([/\t]\+[^/\t]*\)\{1\}$//')
	DOOMPortableCore="$DOOMTrueDir/etc/libretro/core/prboom"
	DOOMPortableFiles="$DOOMTrueDir/DOOM_2_files"
	ok=1
fi

if [ ! -f "$DOOMPortableFiles/doom2.wad" ]; then
	ok=0
fi

if [ "$ok" == 1 ]; then
	decodepng "$DOOMTrueDir/Hakchi_DOOM2_assets/doom2splash-min.png" > /dev/fb0;
	[ -f "$rootfs/share/retroarch/assets/RAloading-min.png" ] && mount_bind "$DOOMTrueDir/Hakchi_DOOM2_assets/doom2splash-min.png" "$rootfs/share/retroarch/assets/RAloading-min.png"
	exec retroarch-clover "../../..$DOOMPortableCore" "$DOOMPortableFiles/doom2.wad"
	umount "$rootfs/share/retroarch/assets/RAloading-min.png"
else
	decodepng "$DOOMTrueDir/Hakchi_DOOM2_assets/doomerror_files-min.png" > /dev/fb0;
	sleep 5
fi
