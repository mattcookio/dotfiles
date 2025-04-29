# -----------------
# Oh My Zsh Core
# -----------------

# Path to your oh-my-zsh installation.
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"

# Path for custom plugins, themes, etc.
# Uses $XDG_CONFIG_HOME if set, otherwise defaults to $HOME/.config
export ZSH_CUSTOM="${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-zsh"

# Set name of the theme to load.
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="minimal"

# --------------------
# Oh My Zsh Settings
# --------------------

# Auto-update settings
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' frequency 13   # Optional: frequency in days

# List of plugins to load.
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git                     # Common git aliases and functions
  gh                      # GitHub CLI integration
  docker                  # Docker completion and aliases
  docker-compose          # Docker Compose completion
  # dotenv                  # Load .env files automatically
  golang                  # Go toolchain helpers
  node                    # Node.js helpers (nvm, etc.)
  npm                     # NPM completion
  macos                   # macOS specific aliases and functions
  brew                    # Homebrew completion and aliases
  systemd                 # systemd completion (mostly for Linux)
  extract                 # Universal extraction function 'x'
  history                 # History navigation commands
  jsontools               # Tools for working with JSON
  sudo                    # Prefix command with sudo by pressing ESC twice
  web-search              # Aliases for web searches
  z                       # Jump quickly to frequent/recent directories
)

# --------------------
# Zsh Options (setopt)
# --------------------

# Correction
setopt CORRECT               # Enable command auto-correction

# History
setopt SHARE_HISTORY         # Share history between running shells
setopt HIST_IGNORE_ALL_DUPS  # Remove older duplicate entries from history
setopt HIST_SAVE_NO_DUPS     # Don't save duplicates to the history file
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first when trimming history
unsetopt HIST_IGNORE_DUPS    # Needed for HIST_IGNORE_ALL_DUPS to work correctly

# -----------------------
# Environment Variables
# -----------------------

# Preferred editor
# Use nvim if available locally, vim otherwise (e.g., SSH sessions)
if [[ -z $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi
export VISUAL="$EDITOR"

# Node Version Manager (n) prefix
export N_PREFIX="$HOME/n"

# Less pager options
# -R: Output raw control characters (for colors)
# --no-init: Don't clear screen on startup
# --quit-if-one-screen: Exit automatically if content fits on one screen
export LESS="-R --no-init --quit-if-one-screen"

# -------------
# PATH Setup
# -------------

# Initialize Homebrew environment (must happen BEFORE sourcing Oh My Zsh for completions)
if [ -x "/opt/homebrew/bin/brew" ]; then # Apple Silicon
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then # Intel
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Add Node Version Manager (n) bin to PATH if not already present
[[ ":$PATH:" == *":${N_PREFIX}/bin:"* ]] || export PATH="${N_PREFIX}/bin:$PATH"
# Add Go bin directory to PATH if it's not already there
if [[ ":$PATH:" != *":$(go env GOPATH)/bin:"* ]]; then
  export PATH="${PATH}:$(go env GOPATH)/bin"
fi

# --------------------
# Load Oh My Zsh
# --------------------
source "$ZSH/oh-my-zsh.sh"

# -------------------------------------------------------------
# Source Homebrew-installed plugins (Must be after sourcing OMZ)
# -------------------------------------------------------------

# Source zsh-autosuggestions from Homebrew location
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Source zsh-syntax-highlighting from Homebrew location
# NOTE: This MUST be the last plugin sourced.
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# --------------------
# User Customizations
# --------------------
#
# Oh My Zsh will automatically source any files ending in .zsh
# placed in the $ZSH_CUSTOM directory:
#   (${ZSH_CUSTOM:-~/.config/oh-my-zsh})
#
# For organization, it's recommended to place:
#   - Aliases in:   $ZSH_CUSTOM/aliases.zsh
#   - Functions in: $ZSH_CUSTOM/functions.zsh
#   - Exports in:   $ZSH_CUSTOM/exports.zsh
#   - Settings in:  $ZSH_CUSTOM/settings.zsh
#
# You can also put everything in $ZSH_CUSTOM/custom.zsh
# Ensure these files exist in your dotfiles and are symlinked by install.sh.

# OR just place custom aliases, functions, or settings below this line
# alias ll='ls -alF'

# pnpm
export PNPM_HOME="/Users/mc/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

PATH=~/.console-ninja/.bin:$PATH
