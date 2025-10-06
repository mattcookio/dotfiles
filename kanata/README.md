# Kanata Configuration

Advanced keyboard remapping with homerow mods and navigation layers.

## Features

### Homerow Modifiers
- **Left hand:** A=Shift, S=Ctrl, D=Alt, F=Cmd
- **Right hand:** J=Cmd, K=Alt, L=Ctrl, ;=Shift

### Caps Lock Remapping
- **Tap:** Backspace
- **Hold:** Navigation layer (HJKL → Arrow keys)

### Navigation Layer (Hold Caps Lock)
- **H** = Left Arrow
- **J** = Down Arrow
- **K** = Up Arrow
- **L** = Right Arrow

### Key Chords
- **D+F** = Escape
- **J+K** = Enter

### Brackets Layer (Hold Space)
- **Left hand:** S={, D=[, F=(
- **Right hand:** J=), K=], L=}

## Installation

### Prerequisites

Kanata requires the Karabiner-Elements virtual HID driver to work on macOS.

1. **Install Karabiner-Elements** (for the driver only):
   ```bash
   brew install --cask karabiner-elements
   ```

2. **Open Karabiner-Elements once** to activate the driver:
   - Launch Karabiner-Elements from Applications
   - Go to System Settings → Privacy & Security
   - Allow the system extension when prompted
   - **Important:** After the driver is activated, quit Karabiner-Elements completely

3. **Verify Karabiner is NOT running:**
   ```bash
   ps aux | grep -i karabiner | grep -v grep
   ```
   You should only see the daemon process, not `karabiner_grabber`

4. **Run the setup script:**
   ```bash
   cd ~/Code/dotfiles
   ./kanata/setup_kanata_daemon.sh
   ```

5. **Grant Input Monitoring permissions:**
   - Go to System Settings → Privacy & Security → Input Monitoring
   - Add and enable `/opt/homebrew/bin/kanata` or your Terminal app

6. **Verify Kanata is running:**
   ```bash
   ps aux | grep kanata | grep -v grep
   sudo launchctl list | grep kanata
   ```

## Troubleshooting

### Kanata won't start
- Check logs: `tail -20 /tmp/kanata.error.log`
- Make sure Karabiner-Elements is NOT running (just the daemon is OK)
- Verify Input Monitoring permissions are granted

### Karabiner-Elements interference
Kanata and Karabiner-Elements cannot run simultaneously. If you want to use Kanata:
```bash
# Quit Karabiner-Elements completely
sudo pkill -9 -i karabiner
sudo launchctl bootout system/org.pqrs.karabiner.karabiner_grabber 2>/dev/null

# Restart Kanata
sudo launchctl bootout system /Library/LaunchDaemons/com.kanata.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/com.kanata.plist
```

### Keys not working as expected
1. Verify the config is valid: `kanata --cfg ~/.config/kanata/kanata.kbd --check`
2. Adjust timing in `kanata.kbd` if needed (currently 150ms)
3. Restart the daemon after config changes

## Customization

Edit `~/.config/kanata/kanata.kbd` to customize:
- Tap-hold timings (currently 150ms)
- Key mappings
- Additional layers

After editing, restart the daemon:
```bash
sudo launchctl bootout system /Library/LaunchDaemons/com.kanata.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/com.kanata.plist
```

## Uninstall

```bash
# Stop and remove the daemon
sudo launchctl bootout system /Library/LaunchDaemons/com.kanata.plist
sudo rm /Library/LaunchDaemons/com.kanata.plist

# Remove config
rm -rf ~/.config/kanata

# Uninstall kanata
brew uninstall kanata

# Optionally uninstall Karabiner-Elements
brew uninstall --cask karabiner-elements
```
