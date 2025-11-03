#!/bin/bash

resolution_laptop=$(wlr-randr | grep -E '[0-9]+x[0-9]+ px.*current' | grep -oE '[0-9]+x[0-9]+' | head -n1)
resolution_monitor=$(wlr-randr | grep -E '[0-9]+x[0-9]+ px.*current' | grep -oE '[0-9]+x[0-9]+' | tail -1)

if [[ "$1" == "monitor" ]]; then
    resolution=$resolution_monitor
else
    resolution=$resolution_laptop
fi

width=$(echo $resolution | cut -d'x' -f1)
height=$(echo $resolution | cut -d'x' -f2)

aspect_ratio=$(( (width * 1000) / height ))

new_height=720
new_width=$(( (new_height * aspect_ratio) / 1000 ))

echo $width $height $new_height $new_width


if [[ "$1" == "monitor" ]]; then
	#gamescope -W $width -H $height -w $new_width -h $new_height --borderless -S stretch -F fsr -- "${@:2}"
	gamescope -W $width -H $height -w $width -h $height -r 144 -F fsr --hdr-debug-force-support --hdr-enabled --force-windows-fullscreen --sdr-gamut-wideness 1 -- "${@:2}"
else
	gamescope --borderless --force-windows-fullscreen -S stretch -F fsr -- "${@}"
fi
