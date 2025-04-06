#!/bin/zsh

# Initialize error tracking
ERRORS=()

# Function to handle errors gracefully
handle_error() {
    local message=$1
    ERRORS+=("$message")
    echo "⚠️  $message"
}

echo "Setting up development environment..."

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || handle_error "Failed to install Homebrew"
fi

# Run install.sh to set up config files
echo "Setting up configuration files..."
if ! ./install.sh; then
    handle_error "Failed to set up configuration files"
fi

# Install basic development tools
echo "Installing development tools..."
# CLI tools
for tool in git neovim ripgrep fd fzf lazygit n go luarocks pipx; do
    echo "Installing $tool..."
    brew install $tool || handle_error "Failed to install $tool"
done

# GUI applications
for app in alacritty vscodium; do
    echo "Installing $app..."
    brew install --cask $app || handle_error "Failed to install $app"
done

# Fonts
for font in font-jetbrains-mono-nerd-font font-jetbrains-mono; do
    echo "Installing $font..."
    brew install --cask $font || handle_error "Failed to install $font"
done

# Install Poetry for Python
echo "Installing Poetry..."
pipx install poetry || handle_error "Failed to install Poetry"

# Verify Neovim installation
echo "Verifying Neovim installation..."
if ! command -v nvim &> /dev/null; then
    handle_error "Neovim not found in PATH"
else
    NVIM_VERSION=$(nvim --version | head -n 1)
    echo "✅ Neovim installed: $NVIM_VERSION"
fi

# Report any errors at the end
if [ ${#ERRORS[@]} -ne 0 ]; then
    echo -e "\n⚠️  The following errors occurred during installation:"
    for error in "${ERRORS[@]}"; do
        echo "  - $error"
    done
    echo -e "\nSome components may not be fully functional. Please check the errors above."
else
    echo -e "\n✅ Development environment setup complete!"
fi 
