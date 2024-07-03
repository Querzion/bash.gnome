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

    # Install Visual Studio Code
    sudo apt install -y wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install -y code

    # Install .NET SDK
    wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    sudo apt update
    sudo apt install -y dotnet-sdk-7.0
}

# Function to install packages using dnf
install_with_dnf() {
    sudo dnf update -y
    sudo dnf install -y gnome-tweaks gnome-extensions-app gnome-shell-extension-manager

    # Install Visual Studio Code
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf check-update
    sudo dnf install -y code

    # Install .NET SDK
    sudo dnf install -y dotnet-sdk-7.0
}

# Function to install packages using pacman
install_with_pacman() {
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm gnome-tweaks gnome-shell-extensions gnome-shell-extension-manager

    # Install Visual Studio Code
    sudo pacman -S --noconfirm code

    # Install .NET SDK
    sudo pacman -S --noconfirm dotnet-sdk
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

# Clone and install upower-battery extension
mkdir -p ~/.local/share/gnome-shell/extensions
cd ~/.local/share/gnome-shell/extensions
git clone https://github.com/codilia/upower-battery.git

# Restart GNOME Shell
echo "Please restart GNOME Shell by pressing Alt+F2, then type 'r' and press Enter."

echo "Installation of GNOME Tweaks, Extensions, Extension Manager, Visual Studio Code, .NET SDK, and upower-battery extension complete!"
