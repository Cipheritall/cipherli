#!/bin/bash

# Vérifier si Python 3 est installé
if ! command -v python3 &> /dev/null; then
    echo "Python3 n'est pas installé. Veuillez l'installer avant de continuer."
    exit 1
fi

# Vérifier si venv est disponible
if ! python3 -m venv --help &> /dev/null; then
    echo "Le module venv n'est pas disponible. Veuillez installer Python 3 avec venv support."
    echo "Sur Debian/Ubuntu : sudo apt-get install python3-venv"
    exit 1
fi

# Créer un environnement virtuel dans le répertoire 'venv'
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo "Environnement virtuel créé dans ./venv"
fi

# Activer le venv
pwd
source $(pwd)/venv/bin/activate

# Vérifier si cryptography est installé dans le venv
pip show cryptography &> /dev/null
if [ $? -ne 0 ]; then
    echo "Installation de la bibliothèque cryptography dans le venv..."
    pip install cryptography
fi

# Définir le chemin du script wrapper
WRAPPER_PATH=$(pwd)"/cipherLi"

# Créer le script wrapper
cat << EOF | sudo tee "$WRAPPER_PATH" > /dev/null
#!/bin/bash
# Wrapper pour lancer main.py de cipherLi

# Chemin absolu vers le script
SCRIPT_DIR="\$(cd "\$(dirname "\$0")" && pwd)"
# Activer le venv
source "\$SCRIPT_DIR/venv/bin/activate"
# Exécuter main.py avec tous les arguments
python "\$SCRIPT_DIR/main.py" -h "\$@"
EOF
# Rendre le wrapper exécutable
sudo chmod 755 "$WRAPPER_PATH" 
# Copier le code dans /opt/cipherLi/
sudo mkdir -p /opt/cipherLi/
# Vérifier si le répertoire existe déjà
if [ -d "/opt/cipherLi/" ]; then
    echo "Le répertoire /opt/cipherLi/ existe déjà. Il sera écrasé."
    sudo rm -rf /opt/cipherLi/*
fi

sudo cp -r $(pwd) /opt/cipherLi/
# Créer un lien symbolique vers le wrapper dans /usr/local/bin
sudo ln -s /opt/cipherLi/cipherLi /bin/cipherLi

echo "Installation terminée. Utilisez 'cipherLi' dans le terminal."
