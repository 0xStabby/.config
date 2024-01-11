cd ~/.config
git init
git remote add origin git@github.com:0xStabby/.config.git
git pull
git checkout master -f
git branch --set-upstream-to origin/master
git submodule update --init --recursive

# set bash to look in ~/.config/bash instead of home dir
sudo echo 'source "$XDG_CONFIG_HOME/bash/.bash_profile"' >> /etc/bash.bashrc
