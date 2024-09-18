#!/bin/bash

# Function to create a new branch
create_branch() {
    read -p "Enter the name of the new branch: " branch_name
    git checkout -b "$branch_name"
    echo "Created and switched to new branch: $branch_name"
}

# Function to switch to an existing branch
switch_branch() {
    git branch
    read -p "Enter the name of the branch to switch to: " branch_name
    git checkout "$branch_name"
    echo "Switched to branch: $branch_name"
}

# Function to list all branches
list_branches() {
    echo "Listing all branches:"
    git branch -a
}

# Main menu
while true; do
    echo "
    Git Branch Management
    1. Create a new branch
    2. Switch to an existing branch
    3. List all branches
    4. Exit
    "
    read -p "Enter your choice: " choice
    case $choice in
        1) create_branch ;;
        2) switch_branch ;;
        3) list_branches ;;
        4) exit 0 ;;
        *) echo "Invalid option" ;;
    esac
    echo "Press Enter to continue..."
    read
done
