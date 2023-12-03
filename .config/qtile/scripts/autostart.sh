#!/usr/bin/env sh

nitrogen --restore &
picom &
lxsession &
dunst &
emacs --daemon &
conky -c .config/conky/conky.conkyrc &
discord --start-minimized &
udiskie &
