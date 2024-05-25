#!/bin/bash

BIN_DIR="$HOME/.bin"
SCRIPT_NAME="print_package_manager_info.sh"
SCRIPT_URL="https://raw.githubusercontent.com/yuanzhixiang/bin/main/$SCRIPT_NAME"

# Create .bin directory if it doesn't exist; otherwise, clear the directory
if [ ! -d "$BIN_DIR" ]; then
    mkdir -p "$BIN_DIR"
else
    rm -rf "$BIN_DIR"/*
fi

# Download the script
curl -fsSL "$SCRIPT_URL" -o "$BIN_DIR/$SCRIPT_NAME"
chmod +x "$BIN_DIR/$SCRIPT_NAME"

# Add script source to .bash_profile if not already added
if ! grep -q "source $BIN_DIR/$SCRIPT_NAME" "$HOME/.bash_profile"; then
    echo "source $BIN_DIR/$SCRIPT_NAME" >> "$HOME/.bash_profile"
fi

echo "Installation completed. The package manager info script will run on each shell session."