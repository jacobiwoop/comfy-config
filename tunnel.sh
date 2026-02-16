#!/bin/bash

# Vérifie si cloudflared est déjà installé
if ! command -v cloudflared >/dev/null 2>&1; then
    echo "Installation de cloudflared..."
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
    mv cloudflared-linux-amd64 /usr/local/bin/cloudflared
    chmod +x /usr/local/bin/cloudflared
else
    echo "cloudflared déjà installé"
fi

# Lance le tunnel et affiche directement l'URL
echo "Démarrage du tunnel sur le port 8188..."
cloudflared tunnel --url http://localhost:8188 2>&1 | grep -o 'https://[-a-z0-9]*\.trycloudflare\.com' 
