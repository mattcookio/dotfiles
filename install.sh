#!/bin/zsh

# Exit on error
set -e

# Check if running from the correct directory
if [ ! -d "nvim" ] || [ ! -d "alacritty" ] || [ ! -d "oh-my-zsh" ] || [ ! -d "claude" ]; then
    echo "Error: This script must be run from the root of your dotfiles directory"
    echo "Please make sure you're in the directory containing nvim/, alacritty/, oh-my-zsh/, claude/"
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
rm -rf ~/.config/oh-my-zsh
rm -rf ~/.claude

# Create new symlinks for entire directories
echo "Creating new symlinks..."
ln -s "$(pwd)/nvim" ~/.config/nvim
ln -s "$(pwd)/alacritty" ~/.config/alacritty
ln -s "$(pwd)/oh-my-zsh" ~/.config/oh-my-zsh
ln -s "$(pwd)/claude" ~/.claude

# Symlink .zshrc
echo "Symlinking .zshrc to home directory..."
rm -f ~/.zshrc # Remove existing file or symlink if it exists
ln -s "$(pwd)/.zshrc" ~/.zshrc

echo "✅ Configuration files and directories have been symlinked successfully!"
