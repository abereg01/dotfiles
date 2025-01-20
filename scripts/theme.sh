#!/usr/bin/env bash

# Configuration
DOTFILES="$HOME/dotfiles"
THEME_DIR="$DOTFILES/themes"
CONFIG_DIR="$DOTFILES/configs/.config"
SCHEMES_DIR="$THEME_DIR/colorschemes"
TEMPLATE_DIR="$THEME_DIR/templates"

# Help message
show_help() {
    echo "Usage: $0 [OPTIONS] [THEME]"
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -l, --list     List available themes"
    echo "  -c, --current  Show current theme"
    echo "  -r, --rofi     Use rofi for theme selection"
    echo "If THEME is provided, switches to that theme"
}

# List available themes
list_themes() {
    find "$SCHEMES_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort
}

# Get current theme
get_current_theme() {
    if [ -f "$CONFIG_DIR/current-theme" ]; then
        cat "$CONFIG_DIR/current-theme"
    else
        echo "No theme currently set"
    fi
}

# Select theme using rofi
rofi_select() {
    list_themes | rofi -dmenu -p "Select theme" -i
}

# Apply theme configuration
apply_theme() {
    local theme=$1
    local theme_dir="$SCHEMES_DIR/$theme"
    local colors_file="$theme_dir/colors.conf"

    # Validate theme exists
    if [ ! -d "$theme_dir" ]; then
        echo "Error: Theme '$theme' not found"
        exit 1
    fi

    echo "Applying theme: $theme"

    # Save current theme
    echo "$theme" > "$CONFIG_DIR/current-theme"
    export theme_name="$theme"  # For use in templates

    # Process colors.conf and export variables
    if [ -f "$colors_file" ]; then
        set -a
        source "$colors_file"
        set +a
    else
        echo "Error: Colors file not found at $colors_file"
        exit 1
    fi

    # Process templates for each application
    # Kitty
    if [ -f "$TEMPLATE_DIR/kitty/theme.conf" ]; then
        mkdir -p "$CONFIG_DIR/kitty"
        envsubst < "$TEMPLATE_DIR/kitty/theme.conf" > "$CONFIG_DIR/kitty/theme.conf"
    fi

    # Rofi
    if [ -f "$TEMPLATE_DIR/rofi.rasi" ]; then
        mkdir -p "$CONFIG_DIR/rofi"
        envsubst < "$TEMPLATE_DIR/rofi.rasi" > "$CONFIG_DIR/rofi/theme.rasi"
    fi

    # Polybar
    if [ -f "$TEMPLATE_DIR/polybar/theme.ini" ]; then
        mkdir -p "$CONFIG_DIR/polybar"
        envsubst < "$TEMPLATE_DIR/polybar/theme.ini" > "$CONFIG_DIR/polybar/theme.ini"
    fi

    # Dunst
    if [ -f "$TEMPLATE_DIR/dunst.conf" ]; then
        mkdir -p "$CONFIG_DIR/dunst"
        envsubst < "$TEMPLATE_DIR/dunst.conf" > "$CONFIG_DIR/dunst/theme.conf"
    fi

    # BSPWM
    if [ -f "$TEMPLATE_DIR/bspwm.conf" ]; then
        mkdir -p "$CONFIG_DIR/bspwm"
        envsubst < "$TEMPLATE_DIR/bspwm.conf" > "$CONFIG_DIR/bspwm/theme"
    fi

    # BAT
    if [ -f "$TEMPLATE_DIR/bat/theme" ]; then
        mkdir -p "$CONFIG_DIR/bat"
        envsubst < "$TEMPLATE_DIR/bat/theme" > "$CONFIG_DIR/bat/theme"
    fi

    # Set wallpaper
    local wallpaper="$theme_dir/wall/"
    if [ -d "$wallpaper" ]; then
        wall_file=$(find "$wallpaper" -type f -print0 | xargs -0 file | grep -i "image" | cut -d: -f1 | head -n1)
        if [ -n "$wall_file" ]; then
            feh --bg-fill "$wall_file"
        fi
    fi

    # Reload applications
    bspc wm -r
    pkill -USR1 -x sxhkd
    killall -USR1 kitty
    killall dunst && dunst &
    polybar-msg cmd restart

    echo "Theme applied successfully!"
}

# Main script logic
main() {
    local theme=""
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -l|--list)
                list_themes
                exit 0
                ;;
            -c|--current)
                get_current_theme
                exit 0
                ;;
            -r|--rofi)
                theme=$(rofi_select)
                ;;
            *)
                theme=$1
                ;;
        esac
        shift
    done

    # If no theme selected, show help
    if [ -z "$theme" ]; then
        show_help
        exit 1
    fi

    # Apply selected theme
    apply_theme "$theme"
}

main "$@"
