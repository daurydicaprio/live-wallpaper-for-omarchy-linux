#!/bin/bash
# ===================================================================================
#   Live Wallpaper Manager for Omarchy & Hyprland (v1.0 Final)
#
#   Features: Automatic optimization, sequential cycling, robust process
#   management, and dynamic theme detection.
# ===================================================================================

# --- SCRIPT CONFIGURATION (Ultra Low-Power) ---
REQUIRED_CMDS=("mpvpaper" "jq" "ffmpeg" "notify-send")
OPTIMIZE_RESOLUTION="1920x1080"
OPTIMIZE_FRAMERATE="15"
OPTIMIZE_QUALITY_CRF="35"
OPTIMIZE_BITRATE="500k"
OPTIMIZE_MAXRATE="750k"
OPTIMIZE_BUFSIZE="1M"
OPTIMIZED_CACHE_DIR_NAME="optimized" # Correct, simple folder name
LIVE_INDEX_FILE="$HOME/.cache/live_wallpaper_index"

# --- PRE-FLIGHT CHECKS ---
for cmd in "${REQUIRED_CMDS[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then exit 1; fi
done

# --- CORE LOGIC ---
THEME_DIR="$HOME/.config/omarchy/current/theme"
if [ ! -d "$THEME_DIR" ]; then exit 1; fi
LIVE_WALLPAPER_DIR="$THEME_DIR/backgrounds/live"
OPTIMIZED_CACHE_DIR="$LIVE_WALLPAPER_DIR/$OPTIMIZED_CACHE_DIR_NAME"
mkdir -p "$OPTIMIZED_CACHE_DIR"

# Function to run the advanced optimization
optimize_video() {
    local original_path="$1"
    local optimized_path="$2"
    if [ ! -f "$optimized_path" ]; then
        notify-send "Live Wallpaper" "Optimizing $(basename "$original_path")..."
        ffmpeg -i "$original_path" -vf "scale=$OPTIMIZE_RESOLUTION,fps=$OPTIMIZE_FRAMERATE" \
        -preset veryfast -c:v libx264 -crf "$OPTIMIZE_QUALITY_CRF" \
        -b:v "$OPTIMIZE_BITRATE" -maxrate "$OPTIMIZE_MAXRATE" -bufsize "$OPTIMIZE_BUFSIZE" \
        -an "$optimized_path" &>/dev/null
    fi
}

# --- DEACTIVATION / CYCLE LOGIC ---
if pgrep -x "mpvpaper" > /dev/null; then
    mapfile -t LIVE_WALLPAPERS < <(find "$LIVE_WALLPAPER_DIR" -maxdepth 1 -type f \( -name "[0-9]*.mp4" -o -name "[0-9]*.webm" -o -name "[0-9]*.mov" \) | sort -V)
    TOTAL_LIVE_WALLPAPERS=${#LIVE_WALLPAPERS[@]}
    CURRENT_INDEX=$(cat "$LIVE_INDEX_FILE" 2>/dev/null || echo 0)
    NEXT_INDEX=$(( CURRENT_INDEX + 1 ))

    if [ "$NEXT_INDEX" -ge "$TOTAL_LIVE_WALLPAPERS" ]; then
        # --- DEACTIVATE ---
        killall mpvpaper
        sleep 0.2
        ~/.local/share/omarchy/bin/omarchy-theme-bg-next
        echo -1 > "$LIVE_INDEX_FILE"
        notify-send "Live Wallpaper" "Cycle finished. Static wallpaper restored." -i "video-display-symbolic"
    else
        # --- CYCLE TO NEXT ---
        killall mpvpaper
        sleep 0.2
        ORIGINAL_VIDEO_PATH="${LIVE_WALLPAPERS[$NEXT_INDEX]}"
        FILENAME=$(basename "$ORIGINAL_VIDEO_PATH")
        OPTIMIZED_VIDEO_PATH="$OPTIMIZED_CACHE_DIR/$FILENAME"
        
        optimize_video "$ORIGINAL_VIDEO_PATH" "$OPTIMIZED_VIDEO_PATH"
        
        mpvpaper -o "no-audio --loop --hwdec=auto-copy" '*' "$OPTIMIZED_VIDEO_PATH" &
        echo "$NEXT_INDEX" > "$LIVE_INDEX_FILE"
        notify-send "Live Wallpaper" "Cycling to: $FILENAME (Optimized)" -i "video-display-symbolic"
    fi
else
    # --- ACTIVATION LOGIC ---
    if [ ! -d "$LIVE_WALLPAPER_DIR" ]; then exit 0; fi
    mapfile -t LIVE_WALLPAPERS < <(find "$LIVE_WALLPAPER_DIR" -maxdepth 1 -type f \( -name "[0-9]*.mp4" -o -name "[0-9]*.webm" -o -name "[0-9]*.mov" \) | sort -V)
    if [ ${#LIVE_WALLPAPERS[@]} -eq 0 ]; then exit 1; fi
    
    killall swaybg &>/dev/null; killall swww-daemon &>/dev/null
    
    ORIGINAL_VIDEO_PATH="${LIVE_WALLPAPERS[0]}"
    FILENAME=$(basename "$ORIGINAL_VIDEO_PATH")
    OPTIMIZED_VIDEO_PATH="$OPTIMIZED_CACHE_DIR/$FILENAME"
    
    optimize_video "$ORIGINAL_VIDEO_PATH" "$OPTIMIZED_VIDEO_PATH"

    mpvpaper -o "no-audio --loop --hwdec=auto-copy" '*' "$OPTIMIZED_VIDEO_PATH" &
    echo 0 > "$LIVE_INDEX_FILE"
    notify-send "Live Wallpaper" "Activated: $FILENAME (Optimized)" -i "video-display-symbolic"
fi
