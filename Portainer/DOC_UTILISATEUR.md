# 🚢 PORTAINER - GUIDE UTILISATEUR

## 👩‍🎓 ESPACE ÉTUDIANT (UTILISATEUR)
**URL** : (Accès restreint)

**C'est quoi ?**
C'est la salle des machines. En général, seul le prof y a accès.
Si vous avez accès, **NE TOUCHEZ À RIEN** sans consigne. Vous pourriez éteindre tout le serveur de la classe.

---

## 👨‍🏫 ESPACE PROFESSEUR (ADMIN)
**URL** : http://admin.ciel.lan
**Login** : `admin`

**C'est quoi ?**
L'interface de gestion absolue de votre infrastructure Docker.

**Actions vitales :**
1. **Redémarrer un service** :
   - Allez dans "Containers".
   - Cochez le service (ex: `filebrowser`).
   - Cliquez sur "Restart".
   - Utile si un service plante.

2. **Voir les Logs** :
   - Cliquez sur l'icône "Liste" (Logs) à côté d'un conteneur.
   - C'est là que vous verrez pourquoi ça ne marche pas (ex: erreur de mot de passe, port déjà utilisé).

3. **Mettre à jour** :
   - Cochez un conteneur -> "Recreate".
   - Cochez "Pull latest image".
   - Portainer va télécharger la dernière version et relancer le service. Magique.
