# CipherLi Release History

## v1.4.1 (Latest)

### Release Title
CipherLi v1.4.1 - Installation Reliability Fix

### Release Date
2024-02-26

### Changes
- Fixed python3-venv detection and installation
- Added explicit pip installation in virtual environment
- Improved package manager detection
- Enhanced virtual environment creation process

## v1.4.0

### Release Title
CipherLi v1.4.0 - Installation System Enhancement

### Release Date
2024-02-25

### Changes
- Added backup of previous installations during updates
- Improved support for environments without sudo
- Enhanced package management compatibility
- Added fallback mechanisms for different system configurations
- Fixed python3-venv dependency installation issues
- Improved virtual environment creation reliability
- Added better error handling during installation

## v1.3.1

### Release Title
CipherLi v1.3.1 - Update System Fix

### Release Date
2024-02-20

### Changes
- Fixed EOF error in update system when running in non-interactive mode
- Added graceful fallback for automated environments
- Improved error handling during update checks
- Enhanced update process stability

## v1.3.0

### Release Title
CipherLi v1.3.0 - Improved Update System

### Release Date
2024-02-15

### Changes
- Improved update system with user confirmation
- Added get.sh script for easier installation
- Better error handling in update process
- Enhanced version checking functionality

## v1.2.0

### Release Title
CipherLi v1.2.0 - Enhanced Encryption Features

### Release Date
2024-02-10

### Changes
- Added folder encryption/decryption support
- Added recursive folder processing with -r flag
- Added automated testing for folder encryption
- Improved error handling for file and folder operations

## v1.1.0

### Release Title
CipherLi v1.1.0 - Update System Integration

### Release Date
2024-01-20

### Changes
- Added automatic update checking system
- Integrated GitHub release tracking
- Added requirements.txt for dependency management
- Improved installation process

### Dependencies Added
- requests
- packaging

## v1.0.0 (Initial Release)

### Release Title
CipherLi v1.0.0 - Secure File Encryption Made Simple

### Release Date
2024-01-15

### Features
- Symmetric file encryption using AES-256-GCM
- Secure password-based key derivation (PBKDF2)
- Command-line interface
- Cross-platform compatibility (Linux-based systems)
- Installation and uninstallation scripts

### Security Features
- Implementation of AES-256 encryption in GCM mode
- Secure random salt generation
- Strong key derivation using PBKDF2
- Authenticated encryption with GCM mode

### Dependencies
- Python 3.6+
- cryptography
