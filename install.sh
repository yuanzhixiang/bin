#!/bin/bash

BIN_DIR="$HOME/.bin"

# Check if git is installed
if ! command -v git >/dev/null; then
    echo "Git is not installed. Attempting to install git..."
    if command -v apt >/dev/null; then
        echo "Installing git using apt..."
        sudo apt update && sudo apt install -y git
    elif command -v yum >/dev/null; then
        echo "Installing git using yum..."
        sudo yum install -y git
    else
        echo "Error: Could not detect a suitable package manager to install git. Please install git manually."
        exit 1
    fi
fi

deleteOldBinFolder() {
    # Create .bin directory if it doesn't exist; otherwise, clear the directory
    ## TODO don't create .bin directory if it doesn't exist
    if [ ! -d "$BIN_DIR" ]; then
        echo "$BIN_DIR does not exist. No files to delete."
        return
    else
        # Print all old files, then delete
        echo "Deleting old files in $BIN_DIR:"
        ls -l "$BIN_DIR"
        rm -rf "$BIN_DIR"
    fi
}

downloadSciptFromGitHub() {
    echo "Downloading all scripts from GitHub to $BIN_DIR..."
    git clone https://github.com/yuanzhixiang/bin.git ${BIN_DIR}

    # Make all downloaded files executable
    chmod +x "$BIN_DIR"/*

    # Add $HOME/.bin to $HOME/.bash_profile if not already added
    if ! grep -q 'export PATH="$HOME/.bin:$PATH"' "$HOME/.bash_profile"; then
        echo 'export PATH="$HOME/.bin:$PATH"' >>"$HOME/.bash_profile"
        echo "Added $HOME/.bin to PATH in .bash_profile"
    fi

    # Source the updated .bash_profile to update the PATH immediately (useful if running interactively)
    if [ -f "$HOME/.bash_profile" ]; then
        source "$HOME/.bash_profile"
    fi
}

deleteOldBinFolder
downloadSciptFromGitHub

echo "Installation completed. The package manager info script will run on each shell session."
