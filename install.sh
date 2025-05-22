#!/bin/bash

# Function to check if command exists and is executable
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to execute with sudo if available
try_sudo() {
    if command_exists sudo; then
        sudo "$@"
    else
        "$@"
    fi
}

# Function to install package
install_package() {
    if command_exists apt-get; then
        try_sudo apt-get update && try_sudo apt-get install -y "$1"
    elif command_exists yum; then
        try_sudo yum install -y "$1"
    else
        echo "Error: Package manager not found. Please install $1 manually."
        exit 1
    fi
}

# Check Python3 and venv
if ! command_exists python3; then
    echo "Installing Python3..."
    install_package python3
fi

# Check and install python3-venv
if ! python3 -m venv --help &> /dev/null; then
    echo "Installing python3-venv..."
    if command_exists apt-get; then
        install_package python3-venv
    elif command_exists yum; then
        install_package python3-pip
        try_sudo python3 -m pip install virtualenv
    fi
fi

# Verify venv is now available
if ! python3 -m venv --help &> /dev/null; then
    echo "Failed to install python3-venv. Please install it manually."
    exit 1
fi

# Backup existing installation if present
if [ -d "/opt/cipherli/" ]; then
    echo "Backing up existing installation..."
    BACKUP_DIR="/opt/cipherli_backup_$(date +%Y%m%d_%H%M%S)"
    try_sudo mv /opt/cipherli "$BACKUP_DIR"
    echo "Previous installation backed up to $BACKUP_DIR"
fi

# Create and copy to installation directory
try_sudo mkdir -p /opt/cipherli
try_sudo cp -r $(pwd)/* /opt/cipherli/

# Create virtual environment with error handling
cd /opt/cipherli
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    if ! python3 -m venv venv; then
        echo "Failed to create virtual environment. Please check your Python installation."
        exit 1
    fi
    echo "Virtual environment created in /opt/cipherli/venv"
fi

# Activate venv and install requirements with error handling
if [ ! -f "venv/bin/activate" ]; then
    echo "Virtual environment activation script not found."
    exit 1
fi

source venv/bin/activate
if ! command_exists pip; then
    echo "pip not found in virtual environment. Installing..."
    try_sudo python3 -m ensurepip
fi

if ! pip install -r requirements.txt; then
    echo "Failed to install requirements. Please check your internet connection."
    exit 1
fi

# Create the wrapper script
cat << EOF | try_sudo tee "/opt/cipherli/cipherLi" > /dev/null
#!/bin/bash
# Wrapper to launch main.py of cipherLi
SCRIPT_DIR=/opt/cipherli
source "\$SCRIPT_DIR/venv/bin/activate"
python "\$SCRIPT_DIR/main.py" "\$@"
EOF

# Set permissions
try_sudo chmod 755 "/opt/cipherli/cipherLi"

# Create symbolic link
try_sudo ln -sf /opt/cipherli/cipherLi /bin/cipherLi

echo "Installation complete. Use 'cipherLi' in the terminal."
