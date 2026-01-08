# 📊 GLANCES - GUIDE UTILISATEUR

## 👩‍🎓 ESPACE ÉTUDIANT (UTILISATEUR)
**URL** : http://monitor.ciel.lan

**C'est quoi ?**
Le tableau de bord de santé du serveur. Ça ressemble aux écrans dans Matrix.

**À observer :**
- **CPU** : Si c'est rouge, le serveur calcule trop.
- **RAM** : Si la barre est pleine, le serveur manque de mémoire.
- **Containers** : La liste des services docker qui tournent.

C'est utile pour comprendre comment une machine fonctionne "sous le capot".

---

## 👨‍🏫 ESPACE PROFESSEUR (ADMIN)
**URL** : http://monitor.ciel.lan

**Utilité Pédagogique :**
- Montrer aux élèves l'impact d'un processus gourmand.
- Détecter si un élève a lancé un script infini qui plante le serveur (CPU à 100%).
- Surveiller l'espace disque restant avant qu'il ne sature.

**Note** : C'est de la lecture seule. Pour agir (tuer un processus), utilisez Portainer.
