#!/usr/bin/env bash

# Terminal colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Installing RPM-OSTree Manager...${NC}"

# 1. Define paths
BIN_PATH="/usr/local/bin/rom"
DESKTOP_PATH="$HOME/.local/share/applications/rpm-ostree-manager.desktop"
ICON_DIR="$HOME/.local/share/icons"
ICON_PATH="$ICON_DIR/rpm-ostree-manager.svg"

# 2. Create directories if they don't exist
mkdir -p "$ICON_DIR"
mkdir -p "$(dirname "$DESKTOP_PATH")"

# 3. Download the main script (rom.sh)
echo "Downloading main script..."
sudo curl -fsSL "https://raw.githubusercontent.com/diogopessoa/rpm-ostree-manager/main/rom.sh" -o "$BIN_PATH"
sudo chmod +x "$BIN_PATH"

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
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=System;
EOF

# Refresh icon cache and desktop database (optional but recommended)
update-desktop-database ~/.local/share/applications/ 2>/dev/null

echo -e "${GREEN}Installation completed successfully!${NC}"
echo "You can now find 'RPM-OSTree Manager' in your application menu or type 'rom' in the terminal."
echo 
echo "PT_BR: Você já pode encontrar o 'RPM-OSTree Manager' menu de aplicativos ou digitar 'rom' no terminal."
