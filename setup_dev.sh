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

# Install Oh My Zsh if not already installed
echo "Checking Oh My Zsh installation..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    # Run Oh My Zsh install script non-interactively
    # Setting CHSH=no prevents the script from trying to change the default shell
    # Setting RUNZSH=no prevents the script from trying to run zsh at the end
    CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || handle_error "Failed to install Oh My Zsh"
else
    echo "Oh My Zsh already installed."
fi

# Install basic development tools
echo "Installing development tools..."
# CLI tools
for tool in git neovim ripgrep fd fzf lazygit n go luarocks pipx zsh-autosuggestions zsh-syntax-highlighting; do
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

# Install Oh My Zsh plugins - Removing manual clones for brew versions
echo "Installing Oh My Zsh plugins..."
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
PLUGINS_DIR="$ZSH_CUSTOM/plugins"
mkdir -p $PLUGINS_DIR

# zsh-autosuggestions - Now handled by Homebrew
# if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
#     echo "Installing zsh-autosuggestions..."
#     git clone https://github.com/zsh-users/zsh-autosuggestions $PLUGINS_DIR/zsh-autosuggestions || handle_error "Failed to clone zsh-autosuggestions"
# else
#     echo "zsh-autosuggestions already installed."
# fi

# zsh-syntax-highlighting - Now handled by Homebrew
# if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
#     echo "Installing zsh-syntax-highlighting..."
#     git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $PLUGINS_DIR/zsh-syntax-highlighting || handle_error "Failed to clone zsh-syntax-highlighting"
# else
#     echo "zsh-syntax-highlighting already installed."
# fi

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
