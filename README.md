# ☁️ SERVEUR CIEL - Infrastructure Docker & Cyber

> **Projet BTS CIEL** : Déploiement d'une infrastructure de services centralisée, sécurisée et segmentée.

Ce dépôt contient la configuration complète (Docker Compose) pour déployer un serveur de classe offrant stockage, monitoring, sécurité DNS et outils pédagogiques.

---

## 🏗️ Architecture "Cyber"

Le projet repose sur une segmentation propre :
1.  **Entrée Unique** : Tout le trafic passe par **Nginx** (Reverse Proxy) sur le port 80.
2.  **DNS Rewriting** : **AdGuard Home** gère la résolution locale (`*.ciel.lan`) pour simuler un réseau d'entreprise.
3.  **Isolation** : Chaque service tourne dans son conteneur Docker dédié.
4.  **Administration** : Gestion graphique via **Portainer**.

---

## 🚀 Services Déployés

Une fois le DNS configuré, les services sont accessibles via des sous-domaines propres :

| Service | URL (Nginx) | URL Secours (Port) | Description |
| :--- | :--- | :--- | :--- |
| **Heimdall** | `http://ciel.lan` | `:8085` | **Portail d'accueil** (Dashboard) |
| **FileBrowser** | `http://files.ciel.lan` | `:8080` | Stockage Cloud & Rendu de TP |
| **AdGuard Home** | `http://adguard.ciel.lan` | `:3000` | DNS, Pare-feu & Filtrage Pub |
| **Portainer** | `http://admin.ciel.lan` | `:9000` | Administration Docker / Logs |
| **Glances** | `http://monitor.ciel.lan` | `:61208` | Monitoring Ressources (CPU/RAM) |
| **IT-Tools** | `http://tools.ciel.lan` | `:8081` | Boîte à outils Réseau/Dev |

---

## 📚 Documentation

Ce dépôt contient toute la documentation nécessaire :

*   **[GUIDE UTILISATEUR (Étudiants & Profs)](DOC_UTILISATEUR.md)** : Comment utiliser les services au quotidien.
*   **[PROCÉDURE D'INSTALLATION (Jour J)](PROCEDURE_CONFIG.txt)** : Checklist de démarrage (Configuration Docker, DNS, etc.).
*   **[ARCHITECTURE RÉSEAU](PROCEDURE_RESEAU.txt)** : Explication du fonctionnement DNS & DHCP.
*   **[FICHE RÉVISION](walkthrough.txt)** : Résumé technique pour l'oral.

---

## 🛠️ Installation Rapide

1.  **Pré-requis** : Un serveur (LXC ou VM) avec Docker & Docker Compose.
2.  **Réseau** :
    ```bash
    docker network create reseau_ciel
    ```
3.  **Démarrage** :
    Allez dans chaque dossier (`Nginx`, `Portainer`, `AdGuard`, etc.) et lancez :
    ```bash
    docker compose up -d
    ```
4.  **Configuration** : Suivez le fichier `PROCEDURE_CONFIG.txt`.

---

### ✨ Fonctionnalités "Wow"
*   **Thème Matrix** : [Voir la procédure](Heimdall/THEME_MATRIX.txt) pour transformer Heimdall.
*   **War Room** : [Voir la procédure](AdGuard/LIVE_WAR_ROOM.txt) pour visualiser les attaques en temps réel.
