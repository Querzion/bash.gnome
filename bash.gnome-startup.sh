#!/bin/bash

# Function to detect package manager
detect_package_manager() {
    if command -v apt-get &> /dev/null; then
        echo "apt"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    else
        echo "Unsupported package manager"
        exit 1
    fi
}

# Function to install packages using apt
install_with_apt() {
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y gnome-tweaks gnome-shell-extensions gnome-shell-extension-manager
}

# Function to install packages using dnf
install_with_dnf() {
    sudo dnf update -y
    sudo dnf install -y gnome-tweaks gnome-extensions-app gnome-shell-extension-manager
}

# Function to install packages using pacman
install_with_pacman() {
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm gnome-tweaks gnome-shell-extensions gnome-shell-extension-manager
}

# Detect the package manager
PACKAGE_MANAGER=$(detect_package_manager)

# Install packages based on the detected package manager
case $PACKAGE_MANAGER in
    apt)
        install_with_apt
        ;;
    dnf)
        install_with_dnf
        ;;
    pacman)
        install_with_pacman
        ;;
    *)
        echo "Unsupported package manager: $PACKAGE_MANAGER"
        exit 1
        ;;
esac

echo "Installation of GNOME Tweaks, Extensions, and Extension Manager complete!"
