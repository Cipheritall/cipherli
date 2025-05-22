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

# Copier le code dans /opt/cipherli/
if [ -d "/opt/cipherli/" ]; then
    echo "Le répertoire /opt/cipherli/ existe déjà. Il sera écrasé."
    sudo rm -rf /opt/cipherli/*
fi

sudo cp -r $(pwd) /opt/

# Créer un environnement virtuel dans le répertoire 'venv'
cd /opt/cipherli
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo "Environnement virtuel créé dans /opt/cipherli/venv"
fi

# Activer le venv
source /opt/cipherli/venv/bin/activate

# Vérifier si cryptography est installé dans le venv
pip show cryptography &> /dev/null
if [ $? -ne 0 ]; then
    echo "Installation de la bibliothèque cryptography dans le venv..."
    pip install cryptography
fi

# Créer le script wrapper
cat << EOF | sudo tee "/opt/cipherli/cipherLi" > /dev/null
#!/bin/bash
# Wrapper pour lancer main.py de cipherLi

# Chemin absolu vers le script
SCRIPT_DIR=/opt/cipherli
# Activer le venv
source "\$SCRIPT_DIR/venv/bin/activate"
# Exécuter main.py avec tous les arguments
python "\$SCRIPT_DIR/main.py" "\$@"
EOF

# Rendre le wrapper exécutable
sudo chmod 755 "/opt/cipherli/cipherLi"

# Créer un lien symbolique vers le wrapper dans /bin
sudo ln -sf /opt/cipherli/cipherLi /bin/cipherLi

echo "Installation terminée. Utilisez 'cipherLi' dans le terminal."
