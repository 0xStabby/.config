source ~/.config/scripts/functions.sh

# Call setup scripts for specific modules
# update mirror list first to get prompts out of the way
sh ~/.config/scripts/update_mirrorlist.sh
sh ~/.config/scripts/clone_config.sh

# setup submodules
sh NO_REBOOT=1 ~/.config/i3/i3install.sh && unset NO_REBOOT
sh ~/.config/bash/setup.sh
sh ~/.config/vim/setup.sh
sh ~/.config/tmux/setup.sh
sh ~/.config/rofi/setup.sh
sh ~/.config/zsh/setup.sh

# set caps to control permanently
sudo localectl set-x11-keymap "" "" "" ctrl:nocaps

# setup dev tools
sh ~/.config/scripts/setup_js.sh
sh ~/.config/scripts/setup_rs.sh
sh ~/.config/scripts/setup_go.sh
sh ~/.config/scripts/setup_py.sh

# install crypto stuff
yay -S frame-eth --noconfirm

# need to install firefox plugins as well yet

echo "Complete setup done!"
# probably reboot here, if i3 was just installed at least
reboot
