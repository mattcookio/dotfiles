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
for tool in git neovim alacritty ripgrep fd fzf lazygit n go luarocks pipx font-jetbrains-mono-nerd-font font-jetbrains-mono vscodium; do
    echo "Installing $tool..."
    brew install $tool || handle_error "Failed to install $tool"
done

# Install Poetry for Python
echo "Installing Poetry..."
pipx install poetry || handle_error "Failed to install Poetry"

# Install Karabiner-Elements
echo "Installing Karabiner-Elements..."
brew install --cask karabiner-elements || handle_error "Failed to install Karabiner-Elements"

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
