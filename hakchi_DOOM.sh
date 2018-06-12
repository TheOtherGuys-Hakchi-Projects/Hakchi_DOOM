#!/bin/sh

ok=0
DOOMPortableCore="$(dirname $0)/etc/libretro/core/prboom"
DOOMPortableFiles="$(dirname $0)/DOOM_1_files"
DOOMPortableAssets="$(dirname $0)/Hakchi_DOOM_assets"
wad=$(ls $DOOMPortableFiles | grep -i doom.wad)
[ -z "$wad" ] && wad=$(ls $DOOMPortableFiles | grep -i doom1.wad)

[ ! -z "$wad" ] && ok=1

if [ "$ok" == 1 ]; then
	decodepng "$DOOMPortableAssets/doom1splash-min.png" > /dev/fb0;
	exec retroarch-clover "../../..$DOOMPortableCore" "$DOOMPortableFiles/$wad" --custom-loadscreen "../../../../../../../$DOOMPortableAssets/doom1splash-min.png"
else
	decodepng "$DOOMPortableAssets/doomerror_files-min.png" > /dev/fb0;
	sleep 5
fi
