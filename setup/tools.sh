#!/usr/bin/env bash

printf "\nInstalling tools...\n"

echo "- homebrew"
sudo true # preauthorize the next command
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &>/dev/null
export PATH=/opt/homebrew/bin:$PATH

echo "- wget"
brew install wget --quiet &>/dev/null

echo "- gpg"
brew install gpg --quiet &>/dev/null

echo "- zip"
brew install zip --quiet &>/dev/null

echo "- unzip"
brew install unzip --quiet &>/dev/null

echo "- vim"
brew install vim --quiet &>/dev/null

echo "- neovim"
brew install neovim --quiet &>/dev/null

echo "- fzf"
brew install fzf --quiet &>/dev/null
"$(brew --prefix)/opt/fzf/install" --all &>/dev/null

echo "- vscode"
brew install --cask visual-studio-code --quiet &>/dev/null
sudo mkdir -p /usr/local/bin
sudo ln -s "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" "/usr/local/bin/code"

echo "- docker"
brew install --cask docker --quiet &>/dev/null

echo "- skhd"
brew install koekeishiya/formulae/skhd --quiet &>/dev/null
brew services start skhd &>/dev/null

echo "- yabai"
brew install koekeishiya/formulae/yabai
brew services start yabai &>/dev/null

echo "- ranger"
brew install ranger --quiet &>/dev/null

echo "- neofetch"
brew install neofetch --quiet &>/dev/null

echo "- zathura"
brew install ripgrep --quiet &>/dev/null

echo "- lazygit"
brew install lazygit --quiet &>/dev/null

echo "- htop"
brew install htop --quiet &>/dev/null

echo "- bat"
brew install bat --quiet &>/dev/null

echo "- jsonpp"
brew install bat --quiet &>/dev/null

echo "- ripgrep"
brew install ripgrep --quiet &>/dev/null

echo "Tools installed!"
