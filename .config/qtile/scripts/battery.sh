#!/usr/bin/env bash
export DISPLAY=:0

battery=$(cat /sys/class/power_supply/BAT0/capacity)
if [[ $battery -lt 20 ]]; then
    message="Battery is low. Please connect your charger."
    /usr/bin/notify-send -u critical "Low Battery" "$message"
fi
