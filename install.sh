#!/bin/bash
# ===================================================================================
#   Installer for Live Wallpaper Manager for Omarchy & Hyprland (v2.0 - AUR Aware)
#
#   This installer intelligently checks for dependencies from both official
#   repositories and the AUR, providing the correct installation command.
# ===================================================================================

echo "--- Live Wallpaper for Omarchy :: Installer ---"

# --- Step 1: Intelligent Dependency Check ---
echo "[1/4] Checking for required commands..."
# We check for commands, not package names, as it's more reliable.
REQUIRED_CMDS=("mpvpaper" "swww" "jq" "ffmpeg" "notify-send")
MISSING_PKGS=() # Store the package names to install

# First, ensure an AUR helper is available
if command -v yay &> /dev/null; then
    AUR_HELPER="yay"
elif command -v paru &> /dev/null; then
    AUR_HELPER="paru"
else
    echo -e "\n\033[1;31mError: No AUR helper (yay or paru) found.\033[0m"
    echo "Please install one to manage AUR packages."
    exit 1
fi
echo "AUR helper '$AUR_HELPER' found."

# Check for each required command
for cmd in "${REQUIRED_CMDS[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
        # Map the command to its package name if they differ
        case "$cmd" in
            "notify-send")
                MISSING_PKGS+=("libnotify")
                ;;
            *)
                MISSING_PKGS+=("$cmd")
                ;;
        esac
    fi
done

# If any packages are missing, provide instructions and exit
if [ ${#MISSING_PKGS[@]} -gt 0 ]; then
    echo -e "\n\033[1;31mError: The following required packages are missing: ${MISSING_PKGS[*]}\033[0m"
    echo "Please install them by running the following command:"
    echo -e "\033[1;32m$AUR_HELPER -S ${MISSING_PKGS[*]}\033[0m"
    exit 1
else
    echo "All dependencies are satisfied."
fi

# --- Step 2: Install the main script ---
echo "[2/4] Installing the main script to ~/.local/bin/..."
mkdir -p ~/.local/bin
cp live-wallpaper-toggle.sh ~/.local/bin/
chmod +x ~/.local/bin/live-wallpaper-toggle.sh
echo "Script installed."

# --- Step 3: Add the keyboard shortcut ---
echo "[3/4] Adding keyboard shortcut to ~/.config/hypr/bindings.conf..."
BINDINGS_FILE="$HOME/.config/hypr/bindings.conf"
SHORTCUT_LINE=$'\n# Live Wallpaper Toggle for Omarchy\nbindd = SUPER CTRL, W, Toggle Live Wallpaper, exec, ~/.local/bin/live-wallpaper-toggle.sh'

# Check if the shortcut already exists to avoid duplicates
if grep -q "live-wallpaper-toggle.sh" "$BINDINGS_FILE"; then
    echo "Shortcut already exists in $BINDINGS_FILE. Skipping."
else
    # Append the shortcut to the file
    echo "$SHORTCUT_LINE" >> "$BINDINGS_FILE"
    echo "Shortcut added successfully."
fi

# --- Step 4: Final instructions ---
echo -e "\n[4/4] \033[1;32mInstallation complete!\033[0m"
echo "------------------------------------------------"
# ...
echo -e "\n[4/4] \033[1;32mInstallation complete!\033[0m"
echo "------------------------------------------------"
echo "IMPORTANT: For the best performance and to ensure all changes are applied,"
echo -e "it is \033[1;33mhighly recommended to reboot your system\033[0m now."
echo "After rebooting, enjoy your live wallpapers with the shortcut Super + Ctrl + W."
