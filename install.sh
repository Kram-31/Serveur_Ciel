#!/bin/bash

# Nom du réseau Docker commun
NETWORK_NAME="reseau_ciel"

# Liste des services (noms des dossiers)
SERVICES=("AdGuard" "Caddy" "FileBrowser" "Glances" "Heimdall" "ITTools" "Portainer" "Vscode")

echo "--- Démarrage de l'installation du Serveur Ciel ---"


# 0. Détection de l'adresse IP de l'hôte
echo "Détection de l'adresse IP..."
# Essaie de récupérer l'IP locale (priorité eth0/wifi)
HOST_IP=$(hostname -I | awk '{print $1}')
if [ -z "$HOST_IP" ]; then
    # Fallback pour certains systèmes
    HOST_IP=$(ip route get 1 | awk '{print $7;exit}')
fi

echo ">> IP détectée : $HOST_IP"

# Mise à jour de la config AdGuard si elle existe
ADGUARD_CONF="AdGuard/conf/AdGuardHome.yaml"
if [ -f "$ADGUARD_CONF" ]; then
    echo ">> Mise à jour de l'IP pour *.ciel.lan dans $ADGUARD_CONF..."
    # Remplace l'IP de la ligne 'answer:' juste après 'domain: *.ciel.lan'
    sed -i "/domain: '\*\.ciel\.lan'/{n;s/answer: .*/answer: $HOST_IP/;}" "$ADGUARD_CONF"
    echo ">> Configuration AdGuard mise à jour avec l'IP $HOST_IP"
else
    echo ">> Fichier de conf AdGuard non trouvé (sera créé au premier lancement)"
fi

# 1. Création du réseau Docker s'il n'existe pas
if [ -z "$(docker network ls -q -f name=^${NETWORK_NAME}$)" ]; then
    echo "Création du réseau docker '$NETWORK_NAME'..."
    docker network create $NETWORK_NAME
else
    echo "Le réseau docker '$NETWORK_NAME' existe déjà."
fi

# 2. Lancement des services
echo "--- Lancement des conteneurs ---"

# Vérification de la présence du dossier principal
if [ -d "Serveur_Ciel" ]; then
    cd Serveur_Ciel
elif [ -d "AdGuard" ]; then
    # Si on est déjà dans le dossier des services (cas où le script est déplacé)
    echo "Détection des services dans le dossier courant."
else
    echo "ERREUR: Impossible de trouver le dossier 'Serveur_Ciel' ou les services."
    echo "Assurez-vous d'exécuter ce script à la racine du projet."
    exit 1
fi

for service in "${SERVICES[@]}"; do
    if [ -d "$service" ]; then
        echo ">> Démarrage de $service..."
        cd "$service"
        # On tente de lancer le compose
        if [ -f "compose.yml" ]; then
             docker compose up -d --remove-orphans
        else
             echo "ATTENTION: Pas de fichier compose.yml trouvé dans $service"
        fi
        cd ..
    else
        echo "ATTENTION: Dossier $service introuvable."
    fi
done

echo "--- Installation terminée ! ---"
echo "Voici l'état actuel des conteneurs :"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
