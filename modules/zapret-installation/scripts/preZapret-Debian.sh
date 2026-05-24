#!/bin/env bash

if [ -d "/opt/zapret" ]; then
    echo "zapret is already installed."
else
    echo "zapret is not installed. Installing..."
    ZAPRET_VER=$(curl -fsSL https://api.github.com/repos/bol-van/zapret/releases/latest \
      | awk -F'"' '/"tag_name"/ {print $4}')
    [ -n "$ZAPRET_VER" ] || { echo "Failed to determine zapret version"; exit 1; }

    curl -fL "https://github.com/bol-van/zapret/releases/download/${ZAPRET_VER}/zapret-${ZAPRET_VER}.tar.gz" \
      -o /tmp/zapret.tar.gz

    tar -xzf /tmp/zapret.tar.gz -C /tmp/
    cd /tmp/zapret-${ZAPRET_VER}
    printf "Y\n\n\n\n\n\nY\n\n\n\n\n" | sudo ./install_easy.sh
fi
