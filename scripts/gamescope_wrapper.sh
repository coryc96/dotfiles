#!/bin/bash

resolution=$(wlr-randr | grep -E '[0-9]+x[0-9]+ px.*current' | grep -oE '[0-9]+x[0-9]+')
width=$(echo $resolution | cut -d'x' -f1)
height=$(echo $resolution | cut -d'x' -f2)

aspect_ratio=$(( (width * 1000) / height ))

new_height=720
new_width=$(( (new_height * aspect_ratio) / 1000 ))

echo $width $height $new_height $new_width


gamescope -W $new_width -H $new_height -w $width -h $height -S stretch --backend sdl -- "$@"
