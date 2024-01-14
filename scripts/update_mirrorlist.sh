mirrorlist_file="/etc/pacman.d/mirrorlist"
read -p "Enter the country for which you want to uncomment servers: " country
sudo curl -o $mirrorlist_file "https://archlinux.org/mirrorlist/?country=all&protocol=http&protocol=https&ip_version=4"
sudo sed -i "/^## $country/,/^$/ s/^#Server/Server/" "$mirrorlist_file"
echo "Servers for $country uncommented in $mirrorlist_file."
sudo pacman -Syu --noconfirm
