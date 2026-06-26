#!/usr/bin/env bash
STATUS_FILE="/tmp/touchpad.status"
DEVICE="elan0412:01-04f3:3240-touchpad"

if [ ! -f "$STATUS_FILE" ] || [ "$(cat "$STATUS_FILE")" = "true" ]; then
    hyprctl eval "hl.device({ name = '$DEVICE', enabled = false })"
    echo "false" > "$STATUS_FILE"
    notify-send "Touchpad" "Turned off"
else
    hyprctl eval "hl.device({ name = '$DEVICE', enabled = true })"
    echo "true" > "$STATUS_FILE"
    notify-send "Touchpad" "Turned on"
fi
