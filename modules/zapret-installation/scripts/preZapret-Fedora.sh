#!/bin/env bash

echo "zapret is not installed. Installing..."
if dnf repolist --all | grep -q "terra"; then
    echo "terra repo is already enabled."
else
echo "terra repo is not enabled. Enabling..."
    sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release -y
fi
