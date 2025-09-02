# Live Wallpaper Manager for Omarchy & Hyprland

A robust and highly efficient script to manage and cycle through live video wallpapers on Hyprland, designed to integrate seamlessly with the Omarchy theme system.

This tool automatically optimizes your video files for minimal resource usage, allows you to cycle through multiple live wallpapers, and safely restores your static wallpaper, all with a single keyboard shortcut.

---

### ✨ Features

-   **On-the-Fly Optimization:** Automatically creates a highly efficient, 1080p, 24fps cached version of your video files to ensure minimal CPU/GPU usage.
-   **Intelligent Toggle:** A single shortcut (`Super + Ctrl + W`) to activate, cycle through, and deactivate your live wallpapers.
-   **Universal Hardware Acceleration:** Uses `mpvpaper` with `hwdec=auto-copy` to leverage the most efficient "zero-copy" hardware decoding available.
-   **Sequential Cycling:** Cycles through all numerically prefixed videos in your theme's `live` folder.
-   **Safe & Robust:** Integrates with Omarchy's default wallpaper script for clean restoration and avoids modifying base system files.

---

### 🚀 Quick Install

Open a terminal and run the following commands:

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/daurydicaprio/live-wallpaper-for-omarchy-linux.git
    cd live-wallpaper-for-omarchy-linux
    ```

2.  **Run the installer:**
    ```sh
    ./install.sh
    ```
The installer will check for dependencies, copy the script to your local path, and add the required keyboard shortcut. After running it, **reload Hyprland** to activate the shortcut.

---

### 📁 **How to Use**

This script is designed to work with Omarchy's theme structure.

#### **Step 1: Create the 'live' Folder**

Inside your active Omarchy theme's `backgrounds` directory, create a new folder named `live`.

**Example Path:**
`~/.config/omarchy/themes/YOUR_THEME/backgrounds/live/`

#### **Step 2: Add and Name Your Videos**

Place your video wallpaper files (`.mp4`, `.webm`, `.mov`, etc.) inside the `live` folder you just created.

To define the cycle order, you **must** name your files with a number prefix.

**Correct Naming Convention:**
- `1-my-cool-video.mp4`
- `2-another-one.webm`
- `10-final-video.mov`

#### **Step 3: Toggle Your Live Wallpaper**

Use the shortcut **`Super + Ctrl + W`**:
-   **First press:** Activates the `1-...` video.
-   **Second press:** Cycles to the `2-...` video.
-   **After the last video:** Deactivates the live wallpaper and restores your static wallpaper.

---

### 🎨 Compatible Themes

Looking for a theme that already supports this structure? Check out [**Pure-Latin Theme**](https://github.com/daurydicaprio/omarchy-pure-latin-theme), a dark, minimalist theme designed for a clean and professional experience.

---

#VERYGoodforlife
