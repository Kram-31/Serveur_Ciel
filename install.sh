#!/bin/bash

# ==========================================
# ☁️ SERVEUR CIEL - SCRIPT D'INSTALLATION
# ==========================================
# A lancer sur un conteneur LXC Debian 12 vierge
# Usage: chmod +x install.sh && ./install.sh

# Couleurs pour le terminal
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}###############################################${NC}"
echo -e "${BLUE}#     DÉMARRAGE DE L'INSTALLATION SERVEUR     #${NC}"
echo -e "${BLUE}###############################################${NC}"

# 1. MISE A JOUR SYSTEME
echo -e "\n${GREEN}[1/6] Mise à jour du système...${NC}"
apt-get update && apt-get upgrade -y
apt-get install -y curl wget git nano ca-certificates gnupg lsb-release

# 2. INSTALLATION DOCKER
echo -e "\n${GREEN}[2/6] Installation de Docker...${NC}"
if ! command -v docker &> /dev/null; then
    # Méthode officielle Docker pour Debian
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg
    
    echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null
      
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    echo "Docker installé avec succès."
else
    echo "Docker est déjà installé."
fi

# 3. CREATION RESEAU
echo -e "\n${GREEN}[3/6] Configuration Réseau Docker...${NC}"
docker network create reseau_ciel || echo "Le réseau 'reseau_ciel' existe déjà."

# 4. CONFIGURATION FILEBROWSER (DOSSIERS & DROITS)
echo -e "\n${GREEN}[4/6] Configuration FileBrowser...${NC}"
cd FileBrowser || exit

# Création de la DB vide si elle n'existe pas
if [ ! -f filebrowser.db ]; then
    touch filebrowser.db
    echo "Fichier filebrowser.db créé."
fi

# Création de l'arborescence
mkdir -p dossier_classe/etu_ciel1
mkdir -p dossier_classe/Rendu_Global
mkdir -p dossier_classe/Ressources_Profs

echo "Application des permissions..."
# Rendu_Global : Ecriture pour l'utilisateur interne (1000)
chown -R 1000:1000 dossier_classe/Rendu_Global
chmod -R 755 dossier_classe/Rendu_Global

# Etu & Ressources : Root (Lecture seule par défaut pour Filebrowser, modifiable par admin)
chown -R root:root dossier_classe/etu_ciel1
chmod -R 755 dossier_classe/etu_ciel1

chown -R root:root dossier_classe/Ressources_Profs
chmod -R 755 dossier_classe/Ressources_Profs

cd ..

# 5. LANCEMENT DES SERVICES
echo -e "\n${GREEN}[5/6] Lancement des services...${NC}"

# Liste des dossiers contenant un compose.yml
SERVICES=("Nginx" "AdGuard" "Portainer" "Heimdall" "FileBrowser" "Glances" "ITTools")

for SERVICE in "${SERVICES[@]}"; do
    if [ -d "$SERVICE" ]; then
        echo -e "Demarrage de ${BLUE}$SERVICE${NC}..."
        cd "$SERVICE"
        docker compose up -d
        cd ..
    else
        echo -e "${RED}Attention: Dossier $SERVICE introuvable !${NC}"
    fi
done

# 6. RECAPITULATIF
IP_LXC=$(hostname -I | cut -d' ' -f1)
echo -e "\n${BLUE}###############################################${NC}"
echo -e "${GREEN}      INSTALLATION TERMINÉE AVEC SUCCÈS !      ${NC}"
echo -e "${BLUE}###############################################${NC}"
echo -e "IP du Serveur : ${IP_LXC}"
echo -e "\nACCÈS SERVICES (Si DNS configuré) :"
echo -e "- Accueil : http://ciel.lan"
echo -e "- Admin   : http://admin.ciel.lan"
echo -e "- Files   : http://files.ciel.lan"
echo -e "- DNS     : http://adguard.ciel.lan"
echo -e "\nACCÈS SECOURS (Si DNS HS) :"
echo -e "- Accueil : http://${IP_LXC}:8085"
echo -e "- Admin   : http://${IP_LXC}:9000"
echo -e "- Files   : http://${IP_LXC}:8080"
echo -e "- DNS     : http://${IP_LXC}:3000"
echo -e "${BLUE}###############################################${NC}"
