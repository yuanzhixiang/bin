#!/bin/bash

if command -v apt-get &> /dev/null; then
    echo "The package manager is: apt-get (Debian/Ubuntu)"
elif command -v yum &> /dev/null; then
    echo "The package manager is: yum (CentOS/RHEL)"
elif command -v dnf &> /dev/null; then
    echo "The package manager is: dnf (Fedora)"
elif command -v pacman &> /dev/null; then
    echo "The package manager is: pacman (Arch Linux)"
elif command -v zypper &> /dev/null; then
    echo "The package manager is: zypper (openSUSE)"
elif command -v emerge &> /dev/null; then
    echo "The package manager is: emerge (Gentoo)"
elif command -v apk &> /dev/null; then
    echo "The package manager is: apk (Alpine)"
else
    echo "Package manager not found."
fi
