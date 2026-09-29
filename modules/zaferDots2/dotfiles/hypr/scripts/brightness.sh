#!/usr/bin/env bash

DEVICE="intel_backlight"
STEP="5%"

case "$1" in
    -u|--up)
        brightnessctl -d "$DEVICE" set "$STEP"+
        ;;
    -d|--down)
        brightnessctl -d "$DEVICE" set "$STEP"-
        ;;
    *)
        echo "Kullanım: $0 {-u (yükselt) | -d (azalt)}"
        exit 1
        ;;
esac
