#!/usr/bin/env bash

# Reject sudo mode
if [[ $(id -u) == 0 ]] && [[ "$SUDO_COMMAND" ]]; then
  echo "Error: This script should not be run with sudo."
  echo "Running as sudo alters the \$HOME variable, leading to incorrect installation paths."
  echo "Instead, run the script directly (e.g., './$(basename "$0")'). The script will prompt for your password when necessary."
  exit 1
fi

script_os="MacOS"
script_pm="brew"

echo "Detected OS: $script_os. Running installation with package manager: $script_pm."
echo "Your password may be requested for privileged commands."

# Keep-alive: ensure sudo stays active during the script
printf "\nEnsuring root access...\n"
sudo -v

# Refresh `sudo` session in the background while script is running
(
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &
) &

# Change to the directory of the script
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd "$dir" || exit

# Source additional setup scripts if they exist
for script in setup/iterm.sh setup/oh-my-zsh.sh setup/symlinks.sh setup/tools.sh; do
  if [[ -f "$script" ]]; then
    . "$script"
  else
    echo "Warning: Could not find setup script $script. Skipping..."
  fi
done

printf "\nAll done!\n"

# Clean up back
