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
    echo
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}           📁 ${GREEN}Dotfiles Manager${BLUE} 📁            ${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo
    echo -e " ${YELLOW}1${NC}) 🔄 Push to GitHub"
    echo -e " ${YELLOW}2${NC}) 📋 Update Package Lists"
    echo -e " ${YELLOW}3${NC}) 🧹 Clean System"
    echo -e "${BLUE}────────────────────────────────────────────────${NC}"
    echo -e " ${YELLOW}4${NC}) 💾 Backup Configs"
    echo -e " ${YELLOW}5${NC}) 📥 Install Configs"
    echo -e " ${YELLOW}6${NC}) 🔗 Sync Configs (stow)"
    echo -e " ${YELLOW}7${NC}) 🐳 Test in Docker"
    echo -e "${BLUE}────────────────────────────────────────────────${NC}"
    echo -e " ${YELLOW}q${NC}) 🚪 Quit"
    echo
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -ne "\n${GREEN}Select an option:${NC} "
}

# Function to sync configs using stow
sync_configs() {
    print_msg "$BLUE" "Syncing configs using stow..."
    
    # Remove existing symlinks
    find "$CONFIG_DIR" -maxdepth 1 -type l -delete
    
    # Stow configs
    cd "$DOTFILES_DIR/configs" || exit 1
    stow . --target="$HOME"
    
    print_msg "$GREEN" "Configs synced successfully"
}

# Function to push to GitHub
github_push() {
    print_msg "$BLUE" "Pushing to GitHub..."
    
    cd "$DOTFILES_DIR" || exit 1
    git add .
    git commit -m "Update dotfiles $(date +%Y-%m-%d)"
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    git push origin "$current_branch"
    
    print_msg "$GREEN" "Push completed"
}

[Previous functions remain the same: backup_configs, install_configs, update_packages, clean_system, test_configs]

# Function to handle menu selection
handle_menu_selection() {
    case $1 in
        1) github_push ;;
        2) update_packages ;;
        3) clean_system ;;
        4) backup_configs ;;
        5) install_configs ;;
        6) sync_configs ;;
        7) test_configs ;;
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
    # Parse multiple flags
    while getopts "ucsgbith" opt; do
        case $opt in
            u) update_packages ;;
            c) clean_system ;;
            s) sync_configs ;;
            g) github_push ;;
            b) backup_configs ;;
            i) install_configs ;;
            t) test_configs ;;
            h)
                echo "Dotfiles Manager - Usage:"
                echo "  -u  Update package lists"
                echo "  -c  Clean system"
                echo "  -s  Sync configs (stow)"
                echo "  -g  Push to GitHub"
                echo "  -b  Backup configs"
                echo "  -i  Install configs"
                echo "  -t  Test in Docker"
                echo "  -h  Show this help message"
                echo
                echo "Flags can be combined, e.g.:"
                echo "  ./manager.sh -ucsg"
                exit 0
                ;;
            \?)
                echo "Invalid option: -$OPTARG"
                exit 1
                ;;
        esac
    done
fi
