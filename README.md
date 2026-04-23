# TP Vault avec GitHub Codespaces – Guide élève

## Contexte

Vous travaillez sur une application Flask fournie dans un dépôt GitHub ouvert dans GitHub Codespaces.

Cette application contient volontairement une mauvaise pratique : un mot de passe est écrit en dur dans le code.

Votre objectif est de :
- démarrer Vault en mode développement
- initialiser des secrets
- créer un accès sécurisé avec une policy
- lancer une application Flask
- comprendre la différence entre une mauvaise pratique et une pratique sécurisée

---

## Utilisation des URLs Codespaces

Dans GitHub Codespaces, ouvrez l'onglet "Ports".

Vous devez repérer :
- le port 5000 pour l'application Flask

Pour accéder à l'application dans le navigateur, utilisez l'URL fournie par Codespaces.

---

## Étape 1 – Se placer dans le bon dossier

Commande :

cd scripts

Cette commande permet d'accéder au dossier contenant les scripts de gestion de Vault.

---

## Étape 2 – Rendre les scripts exécutables

Commande :

chmod +x *.sh

Cette commande permet d'autoriser l'exécution des scripts.

---

## Étape 3 – Démarrer Vault

Commande :

./start-vault-dev.sh

Cette commande permet de :
- démarrer Vault en mode développement
- initialiser un environnement de test avec un token root

---

## Étape 4 – Initialiser les secrets

Commande :

./init-secrets.sh

Cette commande permet de :
- créer un espace de stockage de secrets
- enregistrer un identifiant et un mot de passe dans Vault

---

## Étape 5 – Créer un accès sécurisé

Commande :

./create-limited-token.sh

Cette commande permet de :
- créer une policy limitant les droits d'accès
- générer un token sécurisé basé sur cette policy

---

## Étape 6 – Lancer l'application Flask

Commandes :

cd ../app-python
pip install -r requirements.txt
python app.py

Ces commandes permettent de :
- accéder à l'application
- installer les dépendances nécessaires
- démarrer le serveur Flask

---

## Étape 7 – Tester l'application

Dans le navigateur (via l'URL du port 5000) :

Tester les routes suivantes :

/
insecure
secure

Résultat attendu :
- la route /insecure affiche un mot de passe en clair
- la route /secure récupère le mot de passe depuis Vault

---

## Étape 8 – Identifier la faille

Commande :

cat app.py

Cette commande permet de lire le code et de repérer :
- le mot de passe en dur
- la route insecure

---

## Étape 9 – Corriger le code

Action à réaliser :
- supprimer la variable contenant le mot de passe en dur
- modifier la route insecure pour ne plus afficher de secret

---

## Étape 10 – Relancer l'application

Arrêter l'application avec Ctrl + C puis relancer :

python app.py

---

## Résultat attendu

À la fin du TP :
- Vault fonctionne correctement
- les secrets sont stockés dans Vault
- l'application Flask fonctionne
- la route secure utilise Vault
- la route insecure ne contient plus de mot de passe en clair
- une policy a été appliquée
- un token sécurisé a été généré

---

## Conclusion

Ce TP montre qu'un secret ne doit jamais être stocké dans le code.

Vault permet de centraliser et sécuriser les secrets.

Les policies permettent d'appliquer le principe du moindre privilège.
