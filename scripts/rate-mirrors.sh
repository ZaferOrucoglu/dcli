read -p "select a editor command to edit the mirror list: " editor
read -p "Enter the country code for the mirror list: " country_code
rate-mirrors --allow-root --protocol https --entry-country $country_code arch | sudo tee ~/.cache/rate-mirrors/arch-mirrors

read -p "Do you want to check the rate of the mirrors? (y/n) " answer

if [ "$answer" = "y" ]; then
    $editor ~/.cache/rate-mirrors/arch-mirrors
fi

read -p "Do you accept to change the mirror list? (y/n) " update_pacman

if [ "$update_pacman" = "y" ]; then
    sudo cp ~/.cache/rate-mirrors/arch-mirrors /etc/pacman.d/mirrorlist
    sudo pacman -Syy
else
    echo "Mirror list not updated."
fi
