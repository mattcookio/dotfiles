#!/bin/zsh

# Exit on error
set -e

echo "Setting up development environment..."

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install basic development tools
echo "Installing development tools..."
brew install \
    git \
    neovim \
    alacritty \
    ripgrep \
    fd \
    fzf \
    lazygit \
    n \
    go \
    luarocks \
    pipx \
    font-jetbrains-mono-nerd-font \
    font-jetbrains-mono \
    vscodium

# Install Poetry for Python
pipx install poetry

echo "Development environment setup complete!" 
