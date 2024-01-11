cd ~/.config
git init
git remote add origin git@github.com:0xStabby/.config.git
git pull
git checkout master -f
git branch --set-upstream-to origin/master
git submodule update --init --recursive

sudo -S echo 'export XDG_CONFIG_HOME="$HOME/.config"' >> /etc/bash.bashrc
sudo -S echo 'export XDG_STATE_HOME="$HOME/.local/state"' >> /etc/bash.bashrc
sudo -S echo 'export HISTFILE="$XDG_STATE_HOME/bash/history"' >> /etc/bash.bashrc
sudo -S echo 'source "$XDG_CONFIG_HOME/bash/.bash_profile"' >> /etc/bash.bashrc
