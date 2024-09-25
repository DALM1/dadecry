#!/bin/bash

echo "┓ ┏┏┓┓ ┏┓┏┓┳┳┓┏┓  ┳┓┏┓┓ ┳┳┓┓"
echo "┃┃┃┣ ┃ ┃ ┃┃┃┃┃┣   ┃┃┣┫┃ ┃┃┃┃"
echo "┗┻┛┗┛┗┛┗┛┗┛┛ ┗┗┛  ┻┛┛┗┗┛┛ ┗┻"
echo ""

if ! command -v openssl &> /dev/null
then
    echo "Erreur : OpenSSL n'est pas installé. Veuillez l'installer pour continuer."
    exit 1
fi

read -p "Veuillez entrer le chemin du dossier à déchiffrer : " folder


if [ ! -d "$folder" ]; then
    echo "Erreur : Le dossier spécifié n'existe pas."
    exit 1
fi

read -sp "Entrez la clé de déchiffrement : " key
echo

echo "Déchiffrement des fichiers dans le dossier $folder ..."
find "$folder" -type f -name "*.enc" -exec sh -c 'openssl enc -d -aes-256-cbc -in "$1" -out "${1%.enc}" -k "$2" && rm "$1"' _ {} "$key" \;

if [ $? -eq 0 ]; then
    echo "Tous les fichiers ont été déchiffrés avec succès."
else
    echo "Erreur lors du déchiffrement des fichiers."
    exit 1
fi

echo "Opération terminée."
