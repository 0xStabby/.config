# update mirrorlist
mirrorlist_file="/etc/pacman.d/mirrorlist"
read -p "Enter the country for which you want to uncomment servers: " country
sudo curl -o $mirrorlist_file "https://archlinux.org/mirrorlist/?country=all&protocol=http&protocol=https&ip_version=4"
sudo sed -i "/^## $country/,/^$/ s/^#Server/Server/" "$mirrorlist_file"
echo "Servers for $country uncommented in $mirrorlist_file."
sudo pacman -Syu --noconfirm

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
source $file_path

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

# setup dev tools
# first lets get nodejs/pnpm/nvm
sudo pacman -S nodejs pnpm --noconfirm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
source ~/.config/bash/.bashrc
source ~/.bashrc

pnpm setup

# global npm packages
pnpm add -g hardhat-shorthand \
@ethersproject/cli \
@openapitools/openapi-generator-cli \
@we-bump/lighthouse-cli \
corepack \
csvtojson \
hardhat-shorthand \
pm2 \
pnpm \
serve \
solc \
turbo \
vercel


# install rust and cargo
curl https://sh.rustup.rs -sSf | sh -s -- -y

# get everything I could need for go
sudo pacman -S bison --noconfirm
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source ~/.gvm/scripts/gvm

gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.7

gvm install go1.17.13
gvm use go1.17.13
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.20
gvm use go1.20

# dunno if I can move this yet
# mv ~/.gvm ~/.config/.gvm
# source ~/.config/bash/.bash_profile


# install crypto stuff
yay -S frame-eth --noconfirm

# need to install firefox plugins as well yet
