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

# Check if Python 3 is installed
if ! command_exists python3; then
    echo "Python3 is not installed. Please install it before continuing."
    exit 1
fi

# Check if venv is available
if ! python3 -m venv --help &> /dev/null; then
    echo "The venv module is not available. Please install Python 3 with venv support."
    echo "On Debian/Ubuntu: sudo apt-get install python3-venv"
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

# Create virtual environment
cd /opt/cipherli
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo "Virtual environment created in /opt/cipherli/venv"
fi

# Activate venv and install requirements
source /opt/cipherli/venv/bin/activate
pip install -r requirements.txt

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
