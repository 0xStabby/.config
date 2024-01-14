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

