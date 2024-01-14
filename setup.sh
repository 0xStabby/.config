source ~/.config/scripts/functions.sh

# Call setup scripts for specific modules
# update mirror list first to get prompts out of the way
~/.config/scripts/update_mirrorlist.sh
~/.config/scripts/clone_config.sh

# setup submodules
NO_REBOOT=1 ~/.config/i3/i3install.sh && unset NO_REBOOT
~/.config/bash/setup.sh
~/.config/vim/setup.sh
~/.config/tmux/setup.sh
~/.config/rofi/setup.sh
~/.config/zsh/setup.sh

# set caps to control permanently
localectl set-x11-keymap "" "" "" ctrl:nocaps

# setup dev tools
~/.config/scripts/setup_js.sh
~/.config/scripts/setup_rs.sh
~/.config/scripts/setup_go.sh
~/.config/scripts/setup_py.sh

# install crypto stuff
yay -S frame-eth --noconfirm

# need to install firefox plugins as well yet

echo "Complete setup done!"
# probably reboot here, if i3 was just installed at least
reboot
