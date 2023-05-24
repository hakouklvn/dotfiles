#!/bin/env bash

msgTag="myvolume"

amixer -c 0 set Master "$@" > /dev/null

volume="$(amixer -c 0 get Master | tail -1 | awk '{print $4}' | sed 's/[^0-9]*//g')"
mute="$(amixer -c 0 get Master | tail -1 | awk '{print $6}' | sed 's/[^a-z]*//g')"

if [[ $volume == 0 || "$mute" == "off" ]]; then
    dunstify -a "changeVolume" -t 1500 -u low -i audio-volume-muted -h string:x-dunst-stack-tag:$msgTag "Volume muted"
else
    dunstify -a "changeVolume" -t 1500 -u low -h string:x-dunst-stack-tag:$msgTag \
    -h int:value:"$volume" "Volume: ${volume}%"
fi

canberra-gtk-play -i audio-volume-change -d "changeVolume"
