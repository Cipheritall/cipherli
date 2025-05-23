<p align="center">
    <img src= "https://github.com/Cipheritall/cipherli/blob/main/cipherli.png?raw=true"
        height="300">
</p>
<p align="center">
   <img src="https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=black" />
   <img alt="GitHub Actions Workflow Status" src="https://img.shields.io/github/actions/workflow/status/Cipheritall/cipherli/test.yml">
    
<a href="https://github.com/Cipheritall/cipherli/releases/latest">
<img alt="Dynamic JSON Badge" src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.github.com%2Frepos%2Fcipheritall%2Fcipherli%2Freleases%2Flatest&query=name&logo=auto&label=Latest%20version&labelColor=%23bf9999&color=%23078528&link=https%3A%2F%2Fgithub.com%2FCipheritall%2Fcipherli%2Freleases"></a>
</p>

------

# CipherLi
CipherLi is a command-line tool for file encryption and decryption using symmetric encryption.

## One shot Installation
   ```bash
   curl https://raw.githubusercontent.com/Cipheritall/cipherli/refs/heads/main/get.sh | sh
   ```
   
## Cloned Installation
1. Clone this repository or download the source code
2. Run the installation script:

   ```bash
   sudo ./install.sh
   ```

   This will:
   - Create the necessary directories
   - Set up a Python virtual environment
   - Install required dependencies
   - Create a system-wide `cipherLi` command

## Requirements

- Python 3.6 or higher
- python3-venv package
- Linux-based operating system

## Usage

### Basic Commands

![How to use](./usage.gif "How to use")

Encrypt a file:

```bash
cipherLi encrypt "your-password" input-file.txt encrypted-file.enc
```

Decrypt a file:

```bash
cipherLi decrypt "your-password" encrypted-file.enc decrypted-file.txt
```

Encrypt a folder:

```bash
cipherLi encrypt "your-password" input-folder/ encrypted-folder/ -r
```

Decrypt a folder:

```bash
cipherLi decrypt "your-password" encrypted-folder/ decrypted-folder/ -r
```

The `-r` flag enables recursive processing of subfolders.

### Security Notes

- Always use strong passwords
- Keep your encrypted files and passwords separate
- Backup your files before encryption

## Technical Details

- Uses the `cryptography` library for secure encryption
- Implements AES-256 encryption in GCM mode
- Includes secure key derivation (PBKDF2)

## Version

<a href="https://github.com/Cipheritall/cipherli/releases/latest">
<img alt="Dynamic JSON Badge" src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.github.com%2Frepos%2Fcipheritall%2Fcipherli%2Freleases%2Flatest&query=name&style=for-the-badge&logo=auto&label=Latest%20version&labelColor=%23ff0000&color=%23078528&link=https%3A%2F%2Fgithub.com%2FCipheritall%2Fcipherli%2Freleases">
</a>

## License

This project is open source and available under the MIT License.
