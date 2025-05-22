#!/bin/bash

# Exit on error
set -e

echo "CipherLi Installation Script"
echo "==========================="

# Function to check if command exists and is executable
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install package based on available package manager
install_package() {
    local package=$1
    if command_exists apt-get; then
        if command_exists sudo; then
            sudo apt-get update && sudo apt-get install -y "$package"
        else
            apt-get update && apt-get install -y "$package"
        fi
    elif command_exists yum; then
        if command_exists sudo; then
            sudo yum install -y "$package"
        else
            yum install -y "$package"
        fi
    else
        echo "Warning: Cannot install $package. Please install it manually."
        return 1
    fi
}

# Check dependencies
for cmd in git curl python3; do
    if ! command_exists "$cmd"; then
        echo "$cmd is not installed. Attempting to install..."
        install_package "$cmd" || exit 1
    fi
done

# Create temporary directory
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

echo "Downloading latest CipherLi release..."
LATEST_URL=$(curl -s https://api.github.com/repos/cipheritall/cipherli/releases/latest | grep "tarball_url" | cut -d '"' -f 4)
curl -sL "$LATEST_URL" -o cipherli.tar.gz
mkdir cipherli
tar xzf cipherli.tar.gz --strip-components=1 -C cipherli
cd cipherli

echo "Installing CipherLi..."
chmod +x install.sh
if command_exists sudo; then
    sudo ./install.sh
else
    ./install.sh
fi

# Cleanup
cd /
rm -rf "$TMP_DIR"

echo "CipherLi has been successfully installed!"
echo "Run 'cipherLi --help' to get started."
cipherLi --help