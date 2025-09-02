# Live Wallpaper Manager for Omarchy & Hyprland

A robust and highly efficient script to manage and cycle through live video wallpapers on Hyprland, designed to integrate seamlessly with the Omarchy theme system.

This tool automatically optimizes your video files for minimal resource usage, allows you to cycle through multiple live wallpapers, and safely restores your static wallpaper, all with a single keyboard shortcut.

---

### ✨ Features

-   **On-the-Fly Optimization:** Automatically creates a highly efficient, 1080p, 24fps cached version of your video wallpapers using `ffmpeg` to ensure minimal CPU/GPU usage.
-   **Intelligent Toggle & Cycle:** A single shortcut (`Super + Ctrl + W`) activates, cycles sequentially through all available videos, and deactivates the live wallpaper.
-   **Universal Hardware Acceleration:** Uses `mpvpaper` with `--hwdec=auto-copy` to leverage the most efficient "zero-copy" hardware decoding available on your system (Intel, AMD, or NVIDIA).
-   **Dynamic Theme Integration:** Automatically finds videos from the currently active Omarchy theme's `live` folder.
-   **Robust & Safe:** Designed to not interfere with Omarchy's base files. It intelligently cleans up processes to prevent conflicts or resource leaks.

---

### 🚀 Quick Install (Recommended)

The installer script handles everything for you: dependency checks, file placement, and shortcut configuration.

1.  **Clone the repository anywhere on your system:**
    ```sh
    git clone https://github.com/daurydicaprio/live-wallpaper-for-omarchy-linux.git
    cd live-wallpaper-for-omarchy-linux
    ```

2.  **Run the installer:**
    ```sh
    ./install.sh
    ```

**What the installer does:**
-   Checks if all required dependencies (`mpvpaper`, `jq`, etc.) are installed.
-   Copies the main script to `~/.local/bin/` and makes it executable.
-   **Automatically adds the `Super + Ctrl + W` shortcut** to your `~/.config/hypr/bindings.conf` file.
-   Reminds you to reload Hyprland to activate the new shortcut.

---

### 📁 Usage

1.  **Place Your Videos:** Add your video wallpaper files to your active Omarchy theme's directory:
    `~/.config/omarchy/themes/YOUR_THEME/backgrounds/live/`

2.  **Name Your Videos:** Name your files with a number prefix to define the cycle order (e.g., `1-forest.mp4`, `2-city.webm`, etc.).

3.  **Toggle:** Use the shortcut `Super + Ctrl + W` to activate and cycle through your live wallpapers.

---

### 👤 Author

Created by **Daury DiCaprio**.

-   **Web:** [daurydicaprio.com](https://daurydicaprio.com)
-   **GitHub:** [@daurydicaprio](https://github.com/daurydicaprio)

### 📄 License

This project is licensed under the MIT License.
