#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration
DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles-backup"
CONFIG_DIR="$HOME/.config"

# Function to print colored output
print_msg() {
    local color=$1
    local msg=$2
    echo -e "${color}${msg}${NC}"
}

# Function to show interactive menu
show_menu() {
    clear
    echo "╔═══════════════════════════╗"
    echo "║     Dotfiles Manager      ║"
    echo "╠═══════════════════════════╣"
    echo "║ 1) Sync to GitHub        ║"
    echo "║ 2) Backup Configs        ║"
    echo "║ 3) Install Configs       ║"
    echo "║ 4) Update Package Lists  ║"
    echo "║ 5) Clean System          ║"
    echo "║ 6) Test in Docker        ║"
    echo "║                          ║"
    echo "║ q) Quit                  ║"
    echo "╚═══════════════════════════╝"
    echo
    echo "Select an option: "
}

# Function to handle single keypress input
get_keypress() {
    # Save current terminal settings
    old_tty_settings=$(stty -g)
    
    # Set terminal to raw mode
    stty raw -echo
    
    # Read single character
    char=$(dd bs=1 count=1 2>/dev/null)
    
    # Restore terminal settings
    stty "$old_tty_settings"
    
    echo "$char"
}

# Function to backup configurations
backup_configs() {
    print_msg "$BLUE" "Backing up configurations..."
    
    local backup_dir="$BACKUP_DIR/backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    
    for config in "$CONFIG_DIR"/*; do
        if [ -d "$config" ]; then
            cp -r "$config" "$backup_dir/"
            print_msg "$GREEN" "Backed up $(basename "$config")"
        fi
    done
    
    print_msg "$GREEN" "Backup completed at $backup_dir"
}

# Function to sync and push changes
sync_changes() {
    print_msg "$BLUE" "Syncing changes..."
    
    # Update package lists
    pacman -Qqen > "$DOTFILES_DIR/packages/pacman.txt"
    pacman -Qqem > "$DOTFILES_DIR/packages/aur.txt"
    pacman -Qe | awk '{print $1 " # " $2}' > "$DOTFILES_DIR/packages/packages-with-descriptions.txt"
    
    # Sync configs
    for config in "$CONFIG_DIR"/*; do
        if [ -d "$config" ]; then
            config_name=$(basename "$config")
            if [ -d "$DOTFILES_DIR/configs/$config_name" ]; then
                rm -rf "$DOTFILES_DIR/configs/$config_name"
                cp -r "$config" "$DOTFILES_DIR/configs/"
                print_msg "$GREEN" "Synced $config_name"
            fi
        fi
    done
    
    # Git operations
    cd "$DOTFILES_DIR" || exit 1
    git add .
    git commit -m "Update dotfiles $(date +%Y-%m-%d)"
    # Get current branch name
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git push origin "$current_branch"
    
    print_msg "$GREEN" "Sync completed"
}

# Function to install configurations
install_configs() {
    print_msg "$BLUE" "Installing configurations..."
    
    # Install official packages
    sudo pacman -S --needed - < "$DOTFILES_DIR/packages/pacman.txt"
    
    # Install AUR packages
    yay -S --needed - < "$DOTFILES_DIR/packages/aur.txt"
    
    # Stow configurations
    cd "$DOTFILES_DIR/configs" || exit 1
    for dir in */; do
        stow -v -R -t "$CONFIG_DIR" "${dir%/}"
        print_msg "$GREEN" "Installed ${dir%/}"
    done
    
    print_msg "$GREEN" "Installation completed"
}

# Function to update package lists
update_packages() {
    print_msg "$BLUE" "Updating package lists..."
    
    # Update system
    sudo pacman -Syu
    yay -Syu
    
    # Update package lists
    pacman -Qqen > "$DOTFILES_DIR/packages/pacman.txt"
    pacman -Qqem > "$DOTFILES_DIR/packages/aur.txt"
    
    print_msg "$GREEN" "Package lists updated"
}

# Function to clean system
clean_system() {
    print_msg "$BLUE" "Cleaning system..."
    
    # Remove unused packages
    yay -Rns $(yay -Qdtq)
    
    # Clean package cache
    yay -Sc
    
    print_msg "$GREEN" "System cleaned"
}

# Function to test in clean environment
test_configs() {
    print_msg "$BLUE" "Testing configurations..."
    
    # Check if Docker is installed
    if ! command -v docker &> /dev/null; then
        print_msg "$RED" "Docker is required for testing"
        exit 1
    fi
    
    # Run test in Docker
    docker run -it \
        -v "$DOTFILES_DIR:/root/dotfiles" \
        archlinux:latest \
        bash -c "cd /root/dotfiles && ./scripts/install.sh"
}

# Function to handle menu selection
handle_menu_selection() {
    case $1 in
        1) sync_changes ;;
        2) backup_configs ;;
        3) install_configs ;;
        4) update_packages ;;
        5) clean_system ;;
        6) test_configs ;;
        q|Q) exit 0 ;;
        *) return 1 ;;
    esac
    
    if [ $# -eq 1 ]; then
        echo
        print_msg "$YELLOW" "Press any key to continue..."
        get_keypress
    fi
}

# Main script logic
if [ $# -eq 0 ]; then
    # Interactive mode
    while true; do
        show_menu
        choice=$(get_keypress)
        echo
        handle_menu_selection "$choice"
    done
else
    # Command line mode
    case "$1" in
        -b|--backup)
            backup_configs
            ;;
        -s|--sync)
            sync_changes
            ;;
        -i|--install)
            install_configs
            ;;
        -u|--update)
            update_packages
            ;;
        -c|--clean)
            clean_system
            ;;
        -t|--test)
            test_configs
            ;;
        -h|--help)
            echo "Dotfiles Manager - Usage:"
            echo "  -b, --backup     Backup current configurations"
            echo "  -s, --sync       Sync and push changes to GitHub"
            echo "  -i, --install    Install packages and configurations"
            echo "  -u, --update     Update package lists"
            echo "  -c, --clean      Clean unused packages and cache"
            echo "  -t, --test       Test configurations in a clean environment"
            echo "  -h, --help       Show this help message"
            echo
            echo "Run without arguments for interactive menu"
            ;;
        *)
            echo "Unknown option. Use -h or --help for usage information."
            exit 1
            ;;
    esac
fi
