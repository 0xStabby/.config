sudo pacman -S xorg-server xorg-apps xorg-xinit --no-confirm
sudo pacman -S i3-gaps i3blocks i3lock numlockx --no-confirm

sudo pacman -S lightdm lightdm-gtk-greeter --needed --no-confirm
sudo systemctl enable lightdm

sudo pacman -S noto-fonts ttf-ubuntu-font-family ttf-dejavu ttf-freefont --no-confirm
sudo pacman -S ttf-liberation ttf-droid ttf-roboto terminus-font --no-confirm

sudo pacman -S rxvt-unicode ranger rofi dmenu --needed --no-confirm

sudo pacman -S firefox vlc --needed --no-confirm

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo pacman -S lxappearance --no-confirm

sudo pacman -S arc-gtk-theme --no-confirm
sudo pacman -S papirus-icon-theme --no-confirm

sudo pacman -S gnome-terminal --needed --no-confirm
sudo pacman -S feh picom --no-confirm
sudo pacman -S tmux --no-confirm

sudo echo "[greeter]
   theme-name = Arc-Dark
   icon-theme-name = Papirus-Dark
   background = #2f343f" >> /etc/lightdm/lightdm-gtk-greeter.conf

# get additional i3 scripts setup
# depends on cmatrix
sudo pacman -S cmatrix --no-confirm
git clone git@github.com:0xStabby/i3-scripts.git
sudo mv `\ls -1 ./i3-scripts/* | grep -v .git/` /usr/bin/
rm -rf i3-scripts

reboot
