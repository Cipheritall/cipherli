class CipherLiConfig:
    NAME = "CipherLi"
    VERSION = "1.1.0"
    # Chemin par défaut pour stocker les fichiers temporaires ou autres
    TEMP_DIR = "/tmp/cipherli"
    
    # Chemin du script main.py (si besoin)
    MAIN_SCRIPT_PATH = "main.py"
    
    # Autres paramètres de configuration
    DEFAULT_PASSWORD_PROMPT = "Entrez votre mot de passe : "
    LOG_FILE = "cipherli.log"
    # Ajoutez d'autres paramètres selon vos besoins

    # GitHub repository API URL for version checking
    GITHUB_API_URL = "https://api.github.com/repos/cipheritall/cipherli/releases"
    CHECK_UPDATES = True
