#!/bin/bash

# Exit on error
set -e

echo "CipherLi Installation Script"
echo "==========================="

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Installing..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y git
    elif command -v yum &> /dev/null; then
        sudo yum install -y git
    else
        echo "Error: Cannot install git. Please install it manually."
        exit 1
    fi
fi

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Installing..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y curl
    elif command -v yum &> /dev/null; then
        sudo yum install -y curl
    else
        echo "Error: Cannot install curl. Please install it manually."
        exit 1
    fi
fi

# Check Python requirements
if ! command -v python3 &> /dev/null; then
    echo "Python3 is not installed. Installing..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y python3 python3-venv
    elif command -v yum &> /dev/null; then
        sudo yum install -y python3 python3-venv
    else
        echo "Error: Cannot install Python3. Please install it manually."
        exit 1
    fi
fi

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
sudo ./install.sh

# Cleanup
cd /
rm -rf "$TMP_DIR"

echo "CipherLi has been successfully installed!"
echo "Run 'cipherLi --help' to get started."
cipherLi --help