#!/bin/bash
# ===================================================================================
#   Installer for Live Wallpaper Manager for Omarchy
# ===================================================================================

echo "--- Live Wallpaper for Omarchy :: Installer ---"

# --- Step 1: Check for required packages ---
echo "[1/4] Checking for required packages..."
REQUIRED_PKGS=("mpvpaper" "jq" "ffmpeg" "libnotify" "swww")
MISSING_PKGS=()
for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! pacman -Q "$pkg" &> /dev/null; then
        MISSING_PKGS+=("$pkg")
    fi
done

if [ ${#MISSING_PKGS[@]} -gt 0 ]; then
    echo "The following dependencies are missing: ${MISSING_PKGS[*]}"
    echo "Please install them by running:"
    echo "sudo pacman -S ${MISSING_PKGS[*]}"
    exit 1
else
    echo "All dependencies are satisfied."
fi

# --- Step 2: Copy the main script ---
echo "[2/4] Installing the main script to ~/.local/bin/..."
mkdir -p ~/.local/bin
cp live-wallpaper-toggle.sh ~/.local/bin/
chmod +x ~/.local/bin/live-wallpaper-toggle.sh
echo "Script installed."

# --- Step 3: Add the keyboard shortcut ---
echo "[3/4] Adding keyboard shortcut to ~/.config/hypr/bindings.conf..."
BINDINGS_FILE="$HOME/.config/hypr/bindings.conf"
SHORTCUT_LINE='\n# Live Wallpaper Toggle for Omarchy\nbind = SUPER CTRL, W, exec, ~/.local/bin/live-wallpaper-toggle.sh'

# Check if the shortcut already exists to avoid duplicates
if grep -q "live-wallpaper-toggle.sh" "$BINDINGS_FILE"; then
    echo "Shortcut already exists. Skipping."
else
    # Append the shortcut to the file
    echo -e "$SHORTCUT_LINE" >> "$BINDINGS_FILE"
    echo "Shortcut added."
fi

# --- Step 4: Final instructions ---
echo "[4/4] Installation complete!"
echo "------------------------------------------------"
echo "IMPORTANT: You must now reload Hyprland for the new shortcut to work."
echo "You can do this via the Omarchy menu (Super + Space -> System -> Reload) or by logging out and back in."
echo "Enjoy your live wallpapers!"
