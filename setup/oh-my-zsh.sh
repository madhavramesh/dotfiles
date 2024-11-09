#!/usr/bin/env bash

printf "\nConfiguring oh-my-zsh...\n"

# Check if required commands are available
for cmd in curl git unzip; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Error: $cmd is not installed. Please install it and try again."
    exit 1
  fi
done

# Set ZSH_CUSTOM if not already set
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

echo "- oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &>/dev/null

echo "- zsh-autosuggestions"
git clone -q https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" &>/dev/null

echo "- fast-syntax-highlighting"
git clone -q https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/fast-syntax-highlighting" &>/dev/null

echo "- you-should-use"
git clone -q https://github.com/MichaelAquilina/zsh-you-should-use.git "${ZSH_CUSTOM}/plugins/you-should-use" &>/dev/null

echo "- zsh-vi-mode"
git clone -q https://github.com/jeffreytse/zsh-vi-mode "${ZSH_CUSTOM}/plugins/zsh-vi-mode" &>/dev/null

echo "- zsh-syntax-highlighting"
git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" &>/dev/null

echo "- zsh-bat"
git clone -q https://github.com/fdellwing/zsh-bat.git "${ZSH_CUSTOM}/plugins/zsh-bat" &>/dev/null

echo "- powerlevel10k theme"
git clone -q --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k" &>/dev/null

echo "Finished configuring iterm and zsh!"
