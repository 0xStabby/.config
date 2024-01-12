cd ~/.config
git init
git remote add origin git@github.com:0xStabby/.config.git
git pull
git checkout master -f
git branch --set-upstream-to origin/master
git submodule update --init --recursive --remote

# Define the lines to be added
lines_to_add=(
  'export XDG_CONFIG_HOME="$HOME/.config"'
  'export XDG_STATE_HOME="$HOME/.local/state"'
  'export HISTFILE="$XDG_STATE_HOME/bash/history"'
  'source "$XDG_CONFIG_HOME/bash/.bash_profile"'
)

# Define the file to be modified
file_path="/etc/bash.bashrc"

# Check if each line exists in the file before appending
for line in "${lines_to_add[@]}"; do
  if ! grep -qF "$line" "$file_path"; then
    echo "$line" | sudo tee -a "$file_path"
  else
    echo "Line already exists: $line"
  fi
done

clone_or_check_repo() {
  local github_repo_url="$1"
  local directory_path="$2"

  # Check if the directory exists
  if [ -d "$directory_path" ]; then
    echo "Directory already exists: $directory_path"
  else
    # Clone the GitHub repository
    git clone "$github_repo_url" "$directory_path"
    echo "Cloned GitHub repository to: $directory_path"
  fi
}

# setup vim plugins
clone_or_check_repo "https://github.com/VundleVim/Vundle.vim.git" "vim/bundle/Vundle.vim"
vim +PluginInstall +qall

# set caps to control permanently
localectl set-x11-keymap "" "" "" ctrl:nocaps

# get rofi themes
git clone --depth=1 https://github.com/adi1090x/rofi.git rofi-repo
cd rofi-repo
chmod +x setup.sh
./setup.sh
# cleanup uneeded rofi-repo
cd ../
rm -rf rofi-repo

# get additional i3 scripts setup
git clone https://github.com/0xStabby/i3-scripts.git
mv `\ls -1 ./i3-scripts/* | grep -v .git/` /usr/bin/
rm -rf i3-scripts
