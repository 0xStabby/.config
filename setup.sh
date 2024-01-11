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

# setup vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/vim/bundle/Vundle.vim
vim +PluginInstall +qall
