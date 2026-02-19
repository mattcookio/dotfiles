#!/bin/zsh

# Exit on error
set -e

# Check if running from the correct directory
if [ ! -d "nvim" ] || [ ! -d "claude" ]; then
    echo "Error: This script must be run from the root of your dotfiles directory"
    echo "Please make sure you're in the directory containing nvim/, claude/"
    exit 1
fi

echo "Setting up configuration symlinks..."

# Create necessary directories
echo "Creating ~/.config and ~/.claude directories if they don't exist..."
mkdir -p ~/.config
mkdir -p ~/.claude

# Remove existing symlinks if they exist
echo "Removing existing symlinks..."
rm -rf ~/.config/nvim
rm -rf ~/.config/claude
[ -d "alacritty" ] && rm -rf ~/.config/alacritty
rm -f ~/.claude/settings.json
rm -f ~/.claude/CLAUDE.md
rm -rf ~/.claude/output-styles

# Create new symlinks for entire directories
echo "Creating new symlinks..."
ln -s "$(pwd)/nvim" ~/.config/nvim
# Symlink entire claude directory to ~/.config/claude
ln -s "$(pwd)/claude" ~/.config/claude
[ -d "alacritty" ] && ln -s "$(pwd)/alacritty" ~/.config/alacritty

# Symlink Claude settings and output styles
echo "Symlinking Claude Code settings..."
ln -s "$(pwd)/claude/settings.json" ~/.claude/settings.json
ln -s "$(pwd)/AGENTS.md" ~/.claude/CLAUDE.md
ln -s "$(pwd)/claude/output-styles" ~/.claude/output-styles

# Symlink .zshrc
echo "Symlinking .zshrc to home directory..."
rm -f ~/.zshrc # Remove existing file or symlink if it exists
ln -s "$(pwd)/.zshrc" ~/.zshrc

echo "✅ Configuration files and directories have been symlinked successfully!"
