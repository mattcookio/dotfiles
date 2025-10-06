#!/bin/zsh

# Exit on error
set -e

echo "Setting up Kanata LaunchDaemon..."

# Check if kanata is installed
if ! command -v kanata &> /dev/null; then
    echo "Error: kanata is not installed. Please run setup_dev.sh first."
    exit 1
fi

# Check if Karabiner driver is available
if ! ls /Library/SystemExtensions/*/org.pqrs.Karabiner-DriverKit-VirtualHIDDevice.dext 2>/dev/null; then
    echo "⚠️  Warning: Karabiner virtual HID driver not found."
    echo "Please install Karabiner-Elements to get the driver:"
    echo "  brew install --cask karabiner-elements"
    echo ""
    echo "After installing:"
    echo "  1. Open Karabiner-Elements once to activate the driver"
    echo "  2. Go to System Settings → Privacy & Security and allow the system extension"
    echo "  3. Quit Karabiner-Elements completely"
    echo "  4. Run this script again"
    exit 1
fi

# Create LaunchDaemon plist
PLIST_PATH="/tmp/com.kanata.plist"
cat > "$PLIST_PATH" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.kanata</string>
    <key>ProgramArguments</key>
    <array>
        <string>/opt/homebrew/bin/kanata</string>
        <string>--cfg</string>
        <string>CONFIG_PATH</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/kanata.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/kanata.error.log</string>
</dict>
</plist>
EOF

# Replace CONFIG_PATH with actual path
CONFIG_PATH="$HOME/.config/kanata/kanata.kbd"
sed -i '' "s|CONFIG_PATH|$CONFIG_PATH|g" "$PLIST_PATH"

# Check if config file exists
if [ ! -f "$CONFIG_PATH" ]; then
    echo "Error: Config file not found at $CONFIG_PATH"
    echo "Please run install.sh to symlink the config first."
    exit 1
fi

# Validate the config
echo "Validating Kanata configuration..."
if ! kanata --cfg "$CONFIG_PATH" --check; then
    echo "Error: Invalid Kanata configuration"
    exit 1
fi

# Stop existing daemon if running
echo "Stopping existing Kanata daemon if running..."
sudo launchctl bootout system /Library/LaunchDaemons/com.kanata.plist 2>/dev/null || true

# Install the LaunchDaemon
echo "Installing LaunchDaemon..."
sudo cp "$PLIST_PATH" /Library/LaunchDaemons/com.kanata.plist
sudo chown root:wheel /Library/LaunchDaemons/com.kanata.plist
sudo chmod 644 /Library/LaunchDaemons/com.kanata.plist

# Load the LaunchDaemon
echo "Starting Kanata daemon..."
sudo launchctl bootstrap system /Library/LaunchDaemons/com.kanata.plist

# Wait a moment for it to start
sleep 2

# Check if it's running
if ps aux | grep -v grep | grep kanata > /dev/null; then
    echo "✅ Kanata daemon installed and running successfully!"
    echo ""
    echo "Note: You may need to grant Input Monitoring permissions:"
    echo "  System Settings → Privacy & Security → Input Monitoring"
    echo "  Add /opt/homebrew/bin/kanata or your Terminal app"
    echo ""
    echo "Check logs if needed:"
    echo "  tail -f /tmp/kanata.error.log"
else
    echo "⚠️  Kanata daemon may not be running. Check logs:"
    echo "  tail -20 /tmp/kanata.error.log"
    exit 1
fi
