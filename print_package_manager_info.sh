#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Define function to print message in a box
print_in_box() {
    local s="$*"
    local len=${#s}
    local padding=4
    local total_len=$((len + padding))
    local border=$(printf '%*s' "$total_len" '' | tr ' ' '*')
    printf "${CYAN}+%s+\n" "$border"
    printf "${CYAN}|  %s  |\n" "${NC}${s}${CYAN}"
    printf "${CYAN}+%s+${NC}\n" "$border"
}

# Detect package manager and print the result
if command -v apt-get &> /dev/null; then
    print_in_box "The package manager is: ${GREEN}apt-get (Debian/Ubuntu)${NC}"
elif command -v yum &> /dev/null; then
    print_in_box "The package manager is: ${YELLOW}yum (CentOS/RHEL)${NC}"
elif command -v dnf &> /dev/null; then
    print_in_box "The package manager is: ${PURPLE}dnf (Fedora)${NC}"
elif command -v pacman &> /dev/null; then
    print_in_box "The package manager is: ${BLUE}pacman (Arch Linux)${NC}"
elif command -v zypper &> /dev/null; then
    print_in_box "The package manager is: ${CYAN}zypper (openSUSE)${NC}"
elif command -v emerge &> /dev/null; then
    print_in_box "The package manager is: ${RED}emerge (Gentoo)${NC}"
elif command -v apk &> /dev/null; then
    print_in_box "The package manager is: ${GREEN}apk (Alpine)${NC}"
else
    print_in_box "${RED}Package manager not found.${NC}"
fi