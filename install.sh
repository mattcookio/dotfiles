#!/bin/zsh

# Create necessary directories
mkdir -p ~/.config/nvim
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/karabiner

# Remove existing symlinks if they exist
rm -f ~/.config/nvim/init.lua
rm -f ~/.config/alacritty/alacritty.yml
rm -f ~/.config/karabiner/karabiner.json

# Create new symlinks
ln -s "$(pwd)/nvim/init.lua" ~/.config/nvim/init.lua
ln -s "$(pwd)/alacritty/alacritty.yml" ~/.config/alacritty/alacritty.yml
ln -s "$(pwd)/karabiner/karabiner.json" ~/.config/karabiner/karabiner.json

echo "Configuration files have been symlinked successfully!"
