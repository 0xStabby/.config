echo "I need sudo later but will ask now"
sudo echo "✅"

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

# update mirrors
echo "
## Score: 0.7, United States
Server = http://mirror.us.leaseweb.net/archlinux/$repo/os/$arch
## Score: 0.8, United States
Server = http://lug.mtu.edu/archlinux/$repo/os/$arch
Server = http://mirror.nl.leaseweb.net/archlinux/$repo/os/$arch
## Score: 0.9, United Kingdom
Server = http://mirror.bytemark.co.uk/archlinux/$repo/os/$arch
## Score: 1.5, United Kingdom
Server = http://mirrors.manchester.m247.com/arch-linux/$repo/os/$arch
Server = http://archlinux.dcc.fc.up.pt/$repo/os/$arch
## Score: 6.6, United States
Server = http://mirror.cs.pitt.edu/archlinux/$repo/os/$arch
## Score: 6.7, United States
Server = http://mirrors.acm.wpi.edu/archlinux/$repo/os/$arch
## Score: 6.8, United States
Server = http://ftp.osuosl.org/pub/archlinux/$repo/os/$arch
## Score: 7.1, India
Server = http://mirror.cse.iitk.ac.in/archlinux/$repo/os/$arch
## Score: 10.1, United States
Server = http://mirrors.xmission.com/archlinux/$repo/os/$arch
" | sudo tee /etc/pacman.d/mirrorlist > /dev/null
sudo pacman -Syu

# setup dev tools
# first lets get nodejs/pnpm/nvm
sudo pacman -S nodejs pnpm --noconfirm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# global npm packages
pnpm add -g hardhat-shorthand
pnpm add -g hardhat-shorthand
pnpm add -g @ethersproject/cli
pnpm add -g @openapitools/openapi-generator-cli
pnpm add -g @we-bump/lighthouse-cli
pnpm add -g corepack
pnpm add -g csvtojson
pnpm add -g hardhat-shorthand
pnpm add -g pm2
pnpm add -g pnpm
pnpm add -g serve
pnpm add -g solc
pnpm add -g turbo
pnpm add -g vercel


# get everything I could need for go
sudo pacman -S bison --noconfirm
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
gvm install go1.4
gvm use go1.4 [--default]

gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.7

gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.17.13
gvm use go1.17.13
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.20
gvm use go1.20
