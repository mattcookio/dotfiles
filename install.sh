#!/bin/zsh

# Exit on error
set -e

# Create necessary directories
mkdir -p ~/.config

# Create symlinks
echo "Creating symlinks..."
ln -sf "$(pwd)/nvim" ~/.config/nvim
ln -sf "$(pwd)/alacritty" ~/.config/alacritty

echo "Setup complete!" 