#!/bin/zsh

# Create necessary directories
mkdir -p ~/.config

# Remove existing symlinks if they exist
rm -rf ~/.config/nvim
rm -rf ~/.config/alacritty
rm -rf ~/.config/karabiner

# Create new symlinks for entire directories
ln -s "$(pwd)/nvim" ~/.config/nvim
ln -s "$(pwd)/alacritty" ~/.config/alacritty
ln -s "$(pwd)/karabiner" ~/.config/karabiner

echo "Configuration directories have been symlinked successfully!"
