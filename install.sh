#!/usr/bin/env bash
set -euo pipefail 

# Terminal colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Installing RPM-OSTree Manager...${NC}"

# Detect if running root (build or sudo)
IS_ROOT=false
if [ "$(id -u)" -eq 0 ]; then
  IS_ROOT=true
fi

# Set HOME fallback (build environments)
USER_HOME="${HOME:-/root}"

# 1. Define paths
BIN_PATH="/usr/local/bin/rom"

if [ "$IS_ROOT" = true ]; then
  # modo sistema (compatível com build)
  DESKTOP_PATH="/usr/share/applications/rpm-ostree-manager.desktop"
  ICON_DIR="/usr/share/icons/hicolor/scalable/apps"
  ICON_PATH="$ICON_DIR/rpm-ostree-manager.svg"
else
  # modo usuário (comportamento original)
  DESKTOP_PATH="$USER_HOME/.local/share/applications/rpm-ostree-manager.desktop"
  ICON_DIR="$USER_HOME/.local/share/icons"
  ICON_PATH="$ICON_DIR/rpm-ostree-manager.svg"
fi

ICON_PATH="$ICON_DIR/rpm-ostree-manager.svg"

# 2. Create directories if they don't exist
mkdir -p "$ICON_DIR"
mkdir -p "$(dirname "$DESKTOP_PATH")"

# 3. Download the main script (rom.sh)
echo "Downloading main script..."

SUDO=""
[ "$IS_ROOT" = false ] && SUDO="sudo"

$SUDO curl -fL "https://raw.githubusercontent.com/diogopessoa/rpm-ostree-manager/main/rom.sh" -o "$BIN_PATH"
$SUDO chmod +x "$BIN_PATH"

# 4. Download icon from repository
echo "Downloading icon..."
curl -fsSL "https://raw.githubusercontent.com/diogopessoa/rpm-ostree-manager/main/icon.svg" -o "$ICON_PATH"

# 5. Automatically create the .desktop file
echo "Creating menu shortcut..."
cat <<EOF > "$DESKTOP_PATH"
[Desktop Entry]
Name=RPM-OSTree Manager
Comment=Manage RPMs with RPM-OSTree
Exec=$BIN_PATH
Icon=rpm-ostree-manager
Terminal=true
Type=Application
Categories=System;
EOF

# Refresh icon cache and desktop database (optional but recommended)
update-desktop-database ~/.local/share/applications/ 2>/dev/null

echo -e "${GREEN}Installation completed successfully!${NC}"
echo "You can now find 'RPM-OSTree Manager' in your application menu or type 'rom' in the terminal."
echo 
echo "PT_BR: Encontre o 'RPM-OSTree Manager' no menu de aplicativos ou digitar 'rom' no terminal."
