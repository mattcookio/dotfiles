#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Clean up existing configurations
echo "Cleaning up existing configurations..."
rm -rf ~/.config/nvim
rm -rf ~/.config/alacritty

# Create fresh directories
echo "Creating fresh directories..."
mkdir -p ~/.config/nvim
mkdir -p ~/.config/alacritty

# Copy Neovim files
echo "Copying Neovim configuration..."
cp -r "$SCRIPT_DIR/nvim/"* ~/.config/nvim/

# Copy Alacritty configuration
echo "Copying Alacritty configuration..."
cp "$SCRIPT_DIR/alacritty/alacritty.toml" ~/.config/alacritty/

echo "Installation complete!" 
