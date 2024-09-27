#!/bin/bash

COLORS_FILE="colors"

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "Error: fzf is not installed. Please install it and try again."
    exit 1
fi

# Use fzf to select a .conf file
SELECTED_CONF=$(find . -maxdepth 1 -name "*.conf" | fzf --prompt="Select a .conf file: " --height=40% --layout=reverse --border)

# Check if a file was selected
if [ -z "$SELECTED_CONF" ]; then
    echo "No .conf file selected. Exiting."
    exit 1
fi

# Check if colors file exists
if [ ! -f "$COLORS_FILE" ]; then
    echo "Error: $COLORS_FILE is missing."
    exit 1
fi

# Function to get color from selected .conf file
get_color() {
    grep "^$1" "$SELECTED_CONF" | awk '{print $NF}' | tr -d '\r'
}

# Get specific colors from selected .conf file
FOREGROUND=$(get_color "foreground")
BACKGROUND=$(get_color "background")
COLOR0=$(get_color "color0")
COLOR1=$(get_color "color1")
COLOR2=$(get_color "color2")
COLOR3=$(get_color "color3")
COLOR4=$(get_color "color4")
COLOR5=$(get_color "color5")
COLOR6=$(get_color "color6")
COLOR7=$(get_color "color7")
COLOR8=$(get_color "color8")

# Create a temporary file
TEMP_FILE=$(mktemp)

# Read colors file and replace colors
while IFS= read -r line
do
    case "$line" in
        *'$foreground'*)   line="\$foreground   $FOREGROUND" ;;
        *'$background'*)   line="\$background   $BACKGROUND" ;;
        *'$color0'*)       line="\$color0       $COLOR0" ;;
        *'$color1'*)       line="\$color1       $COLOR1" ;;
        *'$color2'*)       line="\$color2       $COLOR2" ;;
        *'$color3'*)       line="\$color3       $COLOR3" ;;
        *'$color4'*)       line="\$color4       $COLOR4" ;;
        *'$color5'*)       line="\$color5       $COLOR5" ;;
        *'$color6'*)       line="\$color6       $COLOR6" ;;
        *'$color7'*)       line="\$color7       $COLOR7" ;;
        *'$color8'*)       line="\$color8       $COLOR8" ;;
    esac
    echo "$line" >> "$TEMP_FILE"
done < "$COLORS_FILE"

# Check if the temporary file is empty
if [ ! -s "$TEMP_FILE" ]; then
    echo "Error: The resulting file is empty. No changes were made."
    rm "$TEMP_FILE"
    exit 1
fi

# Move the temporary file to replace the original
mv "$TEMP_FILE" "$COLORS_FILE"

echo "Colors have been replaced and cleaned up successfully in $COLORS_FILE!"
echo "Here's the content of the updated file:"
cat "$COLORS_FILE"
