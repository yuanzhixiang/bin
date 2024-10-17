#!/bin/bash

# Define function to print message in a box
print_in_box() {
    local s="$*"
    local len=${#s}
    local padding=4
    local total_len=$((len + padding))
    local border=$(printf '%*s' "$total_len" '' | tr ' ' '*')
    local content_left_padding_len=$((total_len - len))
    local content_left_padding=$(printf '%*s' "$padding" '')
    echo -e "+${border// /*}+"
    echo -e "|  ${s}  |"
    echo -e "+${border// /*}+"
}

# Detect package manager and print the result
if command -v apt-get &> /dev/null; then
    print_in_box "The package manager is: apt-get (Debian/Ubuntu)"
elif command -v yum &> /dev/null; then
    print_in_box "The package manager is: yum (CentOS/RHEL)"
elif command -v dnf &> /dev/null; then
    print_in_box "The package manager is: dnf (Fedora)"
elif command -v pacman &> /dev/null; then
    print_in_box "The package manager is: pacman (Arch Linux)"
elif command -v zypper &> /dev/null; then
    print_in_box "The package manager is: zypper (openSUSE)"
elif command -v emerge &> /dev/null; then
    print_in_box "The package manager is: emerge (Gentoo)"
elif command -v apk &> /dev/null; then
    print_in_box "The package manager is: apk (Alpine)"
else
    print_in_box "Package manager not found."
fi