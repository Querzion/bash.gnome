# GNOME Tools Installation Script
This script installs GNOME Tweaks, GNOME Shell Extensions, and GNOME Shell Extension Manager. 
It automatically detects your package manager (apt, dnf, or pacman) and installs the necessary packages.

## Usage
### Clone the Repository

```bash
git clone https://github.com/yourusername/gnome-tools-installer.git
cd gnome-tools-installer
```

### Make the Script Executable
```bash
chmod +x install_gnome_tools.sh
Run the Script
```

```bash
./install_gnome_tools.sh
```

## What the Script Does
- Detects the package manager (apt, dnf, or pacman).
- Updates the package list.
- Installs GNOME Tweaks, GNOME Shell Extensions, and GNOME Shell Extension Manager.

## Compatibility
### The script is compatible with:

- Debian-based systems (e.g., Ubuntu) using apt.
- Fedora-based systems using dnf.
- Arch-based systems using pacman.
