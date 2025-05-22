class CipherLiConfig:
    NAME = "CipherLi"
    VERSION = "1.2.0"
    # Default path to store temporary files and others
    TEMP_DIR = "/tmp/cipherli"
    
    # Main script path (if needed)
    MAIN_SCRIPT_PATH = "main.py"
    
    # Other configuration parameters
    DEFAULT_PASSWORD_PROMPT = "Enter your password: "
    LOG_FILE = "cipherli.log"
    # Add other parameters as needed

    # GitHub repository API URL for version checking
    GITHUB_API_URL = "https://api.github.com/repos/cipheritall/cipherli/releases"
    CHECK_UPDATES = True
