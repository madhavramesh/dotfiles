#!/usr/bin/env bash

echo "Setting up symlinks..."

function link {
  src="$(pwd)/$1"
  dest="$HOME/$1"
  dateStr=$(date +%Y-%m-%d-%H%M)

  # Check if the source file exists
  if [ ! -e "$src" ]; then
    echo "Warning: Source $src does not exist. Skipping."
    return 1
  fi

  # Ensure the destination parent directory exists for nested paths
  mkdir -p "$(dirname "$dest")"

  if [ -h "$dest" ]; then
    # Delete existing symlink
    rm "$dest"

  elif [ -f "$dest" ]; then
    # Back up existing file
    mv "$dest" "$dest.$dateStr"

  elif [ -d "$dest" ]; then
    # Back up existing directory
    mv "$dest" "$dest.$dateStr"
  fi

  # Create symlink with verbose output
  ln -vs "$src" "$dest"
}

printf "\nCreating symlinks\n"
link .gitconfig
link .gitignore_global
link .zshrc
link .p10k.zsh
link .config/nvim
link .config/skhd
link .config/yabai
link .config/zathura
link .config/ranger
link .config/neofetch

echo "Symlinks created!"
