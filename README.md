# Live Wallpaper Manager for Omarchy & Hyprland

A robust and highly efficient script to manage and cycle through live video wallpapers on Hyprland, designed to integrate seamlessly with the Omarchy theme system.

This tool automatically optimizes your video files for minimal resource usage, allows you to cycle through multiple live wallpapers, and safely restores your static wallpaper, all with a single keyboard shortcut.

Created by **Daury Dicaprio** ([daurydicaprio.com](https://daurydicaprio.com)) | Official Omarchy Website: [omarchy.org](https://omarchy.org)

---

### 📋 How to Use

This script is designed to work with Omarchy's theme structure.

#### **Step 1: Create the 'live' Folder**

Inside your active Omarchy theme's `backgrounds` directory, create a new folder named `live`.

**Example Path:** `~/.config/omarchy/themes/YOUR_THEME/backgrounds/live/`

#### **Step 2: Add and Name Your Videos**

Place your video wallpaper files (`.mp4`, `.webm`, `.mov`, etc.) inside the `live` folder. To define the cycle order, you **must** name your files with a number prefix.

**Correct Naming:**
- `1-my-cool-video.mp4`
- `2-another-one.webm`

#### **Step 3: Toggle Your Live Wallpaper**

Use the shortcut **`Super + Ctrl + W`**:
-   **First press:** Activates the `1-...` video.
-   **Second press:** Cycles to the `2-...` video.
-   **After the last video:** Deactivates and restores your static wallpaper.

---

### ✨ Features

-   **On-the-Fly Optimization:** Automatically creates a highly efficient, 1080p, 24fps cached version of your videos to ensure minimal CPU/GPU usage.
-   **Universal Hardware Acceleration:** Uses `mpvpaper` with `hwdec=auto-copy` for the most efficient hardware decoding.
-   **Safe & Robust:** Integrates with Omarchy's default wallpaper script for clean restoration.
-   **Descriptive Shortcut:** Uses Omarchy's `bindd` syntax to show a clean description in the keybinding helper.

---

### 🚀 Quick Install

Open a terminal and run the following commands:

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/daurydicaprio/live-wallpaper-for-omarchy-linux.git
    cd live-wallpaper-for-omarchy-linux
    ```
    
2.  **Make the installer executable:**
    ```sh
    chmod +x install.sh
    ```

3.  **Run the installer:**
    ```sh
    ./install.sh
    ```
After installation, **reload Hyprland** to activate the shortcut.

---

### 🎨 Compatible Themes

Looking for a theme that already supports this structure? Check out [**Pure-Latin Theme**](https://github.com/daurydicaprio/omarchy-pure-latin-theme), a dark, minimalist theme designed for a clean and professional experience.

---

### 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

#VERyGoodforlife
