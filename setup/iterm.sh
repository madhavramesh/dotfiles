#!/usr/bin/env bash

printf "\nConfiguring iterm2...\n"

# Download and install iTerm2 if not already installed
if ! command -v /Applications/iTerm.app &>/dev/null; then
  echo "- Downloading iTerm2"
  curl -L -o iTerm2.zip https://iterm2.com/downloads/stable/latest
  unzip -qq iTerm2.zip -d /Applications
  rm iTerm2.zip
  echo "iTerm2 installed."
else
  echo "iTerm2 is already installed."
fi

# Download Gruvbox color scheme for iTerm2
echo "- Downloading Gruvbox color scheme"
mkdir -p "$HOME/.config/iterm2"
curl -L -o "$HOME/.config/iterm2/Gruvbox.itermcolors" https://raw.githubusercontent.com/morhetz/gruvbox-contrib/master/iterm2/Gruvbox-dark.itermcolors

# Step 3: Import Gruvbox color scheme into iTerm2 and set it as default
echo "- Applying Gruvbox color scheme"
osascript <<EOF
tell application "iTerm"
    activate
    delay 1
    -- Import Gruvbox color scheme
    tell current window
        create tab with default profile
    end tell
end tell

-- Load Gruvbox color scheme
tell application "System Events"
    tell process "iTerm2"
        keystroke "o" using {command down}
        delay 1
        keystroke "p"
        delay 1
        keystroke return
    end tell
end tell
EOF

echo "- Installing FiraCode Nerd Font"
# Determine font path based on OS type
if [[ "$OSTYPE" == 'darwin'* ]]; then
  font_path="$HOME/Library/Fonts"
else
  font_path="$HOME/.local/share/fonts"
fi

mkdir -p "$font_path"

# Download and unzip FiraCode Nerd Font
curl -sSOL 'https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip'
if [ -f FiraCode.zip ]; then
  mkdir -p FiraCode
  unzip -qq FiraCode.zip -d FiraCode
  cp FiraCode/Fira\ Code\ *\ Nerd\ Font\ Complete\ Mono.ttf "$font_path"
  rm -rf FiraCode.zip FiraCode
else
  echo "Error: Failed to download FiraCode Nerd Font."
fi


echo "Gruvbox color scheme applied to iTerm2!"
