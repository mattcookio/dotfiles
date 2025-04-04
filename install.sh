#!/bin/zsh

# Exit on error
set -e

# Check if running from the correct directory
if [ ! -d "nvim" ] || [ ! -d "alacritty" ]; then
    echo "Error: This script must be run from the root of your dotfiles directory"
    echo "Please make sure you're in the directory containing nvim/, alacritty/"
    exit 1
fi

echo "Setting up configuration symlinks..."

# Create necessary directories
echo "Creating ~/.config directory if it doesn't exist..."
mkdir -p ~/.config

# Remove existing symlinks if they exist
echo "Removing existing symlinks..."
rm -rf ~/.config/nvim
rm -rf ~/.config/alacritty

# Create new symlinks for entire directories
echo "Creating new symlinks..."
ln -s "$(pwd)/nvim" ~/.config/nvim
ln -s "$(pwd)/alacritty" ~/.config/alacritty

echo "✅ Configuration directories have been symlinked successfully!"
