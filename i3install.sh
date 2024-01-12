sudo pacman -S xorg-server xorg-apps xorg-xinit --noconfirm
sudo pacman -S i3-gaps i3blocks i3lock numlockx --noconfirm

sudo pacman -S lightdm lightdm-gtk-greeter --needed --noconfirm
sudo systemctl enable lightdm

sudo pacman -S noto-fonts ttf-ubuntu-font-family ttf-dejavu ttf-freefont --noconfirm
sudo pacman -S ttf-liberation ttf-droid ttf-roboto terminus-font --noconfirm

sudo pacman -S rxvt-unicode ranger rofi dmenu --needed --noconfirm

sudo pacman -S firefox vlc --needed --noconfirm

sudo pacman -S lxappearance --noconfirm

sudo pacman -S arc-gtk-theme --noconfirm
sudo pacman -S papirus-icon-theme --noconfirm

sudo pacman -S gnome-terminal ncdu --needed --noconfirm
sudo pacman -S feh picom --noconfirm
sudo pacman -S tmux --noconfirm

# install zsh
sudo pacman -S zsh --needed --noconfirm
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo echo "[greeter]
   theme-name = Arc-Dark
   icon-theme-name = Papirus-Dark
   background = #2f343f" >> /etc/lightdm/lightdm-gtk-greeter.conf

# get additional i3 scripts setup
# depends on cmatrix
sudo pacman -S cmatrix --noconfirm
git clone git@github.com:0xStabby/i3-scripts.git
sudo mv `\ls -1 ./i3-scripts/* | grep -v .git/` /usr/bin/
rm -rf i3-scripts

# dark mode by default
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

reboot
