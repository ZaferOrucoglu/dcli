#!/usr/bin/env bash

#sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
#sudo pacman-key --lsign-key 3056513887B78AEB
#sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
#sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
#printf "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist\n" | sudo tee -a /etc/pacman.conf
#sudo pacman -Syu

read -p "select a editor command to edit the mirror list: " editor
read -p "Enter the country code for the mirror list: " country_code
rate-mirrors --allow-root --protocol https --entry-country $country_code chaotic-aur | sudo tee ~/.cache/chaotic-aur-mirrors

read -p "Do you want to check the rate of the mirrors? (y/n) " answer

if [ "$answer" = "y" ]; then
    $editor ~/.cache/chaotic-aur-mirrors
fi

read -p "Do you accept to change the mirror list? (y/n) " update_pacman

if [ "$update_pacman" = "y" ]; then
    sudo cp ~/.cache/chaotic-aur-mirrors /etc/pacman.d/chaotic-mirrorlist
    sudo pacman -Syy
else
    echo "Mirror list not updated."
fi
