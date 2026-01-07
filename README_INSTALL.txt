ORDRE D'INSTALLATION SUR LE SERVEUR PROD :

1. PRÉPARATION SYSTÈME (Si Ubuntu) :
   - Libérer le port 53 (désactiver systemd-resolved si besoin).
   - Créer le réseau Docker : 
     docker network create reseau_ciel

2. LANCEMENT DES SERVICES (Dans l'ordre) :
   - Filebrowser : docker-compose up -d (à la racine)
   - Heimdall : cd heimdall && docker-compose up -d
   - AdGuard : cd adguard && docker-compose up -d

3. CONFIGURATION INITIALE ADGUARD :
   - Aller sur http://IP_DU_SERVEUR:3000
   - Mettre Admin Web sur port 80.
   - Mettre DNS sur port 53.
   - Créer le compte admin.

4. LANCEMENT DU CHEF D'ORCHESTRE :
   - Nginx : cd nginx && docker-compose up -d

5. FINITION :
   - Aller sur http://IP_DU_SERVEUR/adguard/ -> Configurer la réécriture DNS (ciel.lan = IP_SERVEUR).
   - Aller sur http://ciel.lan -> Configurer les boutons Heimdall.
