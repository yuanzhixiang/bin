#!/bin/bash

BIN_DIR="$HOME/.bin"
SCRIPT_NAME="print_package_manager_info.sh"
SCRIPT_URL="https://raw.githubusercontent.com/yuanzhixiang/bin/main/$SCRIPT_NAME"

# Create .bin directory if it doesn't exist
[ ! -d "$BIN_DIR" ] && mkdir -p "$BIN_DIR"

# Download the script
curl -fsSL "$SCRIPT_URL" -o "$BIN_DIR/$SCRIPT_NAME"
chmod +x "$BIN_DIR/$SCRIPT_NAME"

# Add script source to .bashrc if not already added
if ! grep -q "source $BIN_DIR/$SCRIPT_NAME" "$HOME/.bashrc"; then
    echo "source $BIN_DIR/$SCRIPT_NAME" >> "$HOME/.bashrc"
fi

echo "Installation completed. The package manager info script will run on each shell session."