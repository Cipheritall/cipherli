#!/bin/bash

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Python3 is not installed. Please install it before continuing."
    exit 1
fi

# Check if venv is available
if ! python3 -m venv --help &> /dev/null; then
    echo "The venv module is not available. Please install Python 3 with venv support."
    echo "On Debian/Ubuntu: sudo apt-get install python3-venv"
    exit 1
fi

# Copy code to /opt/cipherli/
if [ -d "/opt/cipherli/" ]; then
    echo "Directory /opt/cipherli/ already exists. It will be overwritten."
    sudo rm -rf /opt/cipherli/*
fi

sudo cp -r $(pwd) /opt/

# Create virtual environment in 'venv' directory
cd /opt/cipherli
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo "Virtual environment created in /opt/cipherli/venv"
fi

# Activate venv
source /opt/cipherli/venv/bin/activate

echo "Installing required libraries in venv..."
pip install -r requirements.txt

# Create the wrapper script
cat << EOF | sudo tee "/opt/cipherli/cipherLi" > /dev/null
#!/bin/bash
# Wrapper to launch main.py of cipherLi

# Absolute path to the script
SCRIPT_DIR=/opt/cipherli
# Activate venv
source "\$SCRIPT_DIR/venv/bin/activate"
# Execute main.py with all arguments
python "\$SCRIPT_DIR/main.py" "\$@"
EOF

# Make the wrapper executable
sudo chmod 755 "/opt/cipherli/cipherLi"

# Create a symbolic link to the wrapper in /bin
sudo ln -sf /opt/cipherli/cipherLi /bin/cipherLi

echo "Installation complete. Use 'cipherLi' in the terminal."
