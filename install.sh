#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function to safely create symlink
create_symlink() {
    local source=$1
    local target=$2

    # Remove existing symlink or file/directory
    if [ -L "$target" ] || [ -e "$target" ]; then
        echo "Removing existing $target..."
        rm -rf "$target"
    fi

    # Create parent directories if they don't exist
    mkdir -p "$(dirname "$target")"

    # Create symlink
    echo "Creating symlink: $target -> $source"
    ln -s "$source" "$target"
}

# Clean up existing symlinks
echo "Cleaning up existing symlinks..."
rm -f ~/.config/nvim
rm -f ~/.config/alacritty

# Create symlinks
echo "Creating symlinks..."
create_symlink "$SCRIPT_DIR/nvim" ~/.config/nvim
create_symlink "$SCRIPT_DIR/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml

echo "Installation complete!"
