#!/bin/env bash

dir = "~/.config/dcli/modules/zapret-installation/configs/debian"
sudo cp "$dir/dnscrypt-proxy.toml" /etc/dnscrypt-proxy.toml
sudo cp "$dir/config" /opt/zapret/config
# Setting the blacklist of zapret and enable it
echo "Do you want to add websites to the Zapret exclude list?"
while true; do
    read -p "Enter 'y/yes' or 'n/no': " answer
    if [[ "${answer,,}" == "y" || "${answer,,}" == "yes" ]]; then
        # Run initial setup once
        sudo bash /opt/zapret/ipset/get_exclude.sh

        # Let user add websites until they type c or cancel
        while true; do
            read -p "Enter website URL (just 1 website each answer, type c or cancel to finish adding): " website
            if [[ "${website,,}" == "c" || "${website,,}" == "cancel" ]]; then
                echo "Finished adding websites."
                break
            elif [[ -z "$website" ]]; then
                echo "Empty input. Please enter a website or 'c'/'cancel' to finish."
                continue
            else
                echo "$website" | sudo tee -a /opt/zapret/ipset/zapret-hosts-user-exclude.txt > /dev/null
                echo "Added!"
            fi
        done
        break
    elif [[ "${answer,,}" == "n" || "${answer,,}" == "no" ]]; then
        echo "Skipping adding websites."
        break
    else
        # handling invalid input
        echo "Invalid input. Please enter 'y/yes' or 'n/no'."
    fi
done
