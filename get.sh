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

echo "Downloading CipherLi..."
git clone https://github.com/cipheritall/cipherli.git
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