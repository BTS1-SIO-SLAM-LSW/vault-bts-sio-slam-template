# TP Vault avec GitHub Codespaces – Guide élève

## Contexte

Vous travaillez sur une application Flask fournie dans un dépôt GitHub ouvert dans GitHub Codespaces.

Cette application contient volontairement une mauvaise pratique : un mot de passe est écrit en dur dans le code.

Votre objectif est de :
- démarrer l'environnement dans Codespaces
- initialiser HashiCorp Vault
- lancer l'application Flask
- tester les routes de l'application
- appliquer une policy Vault
- corriger le code pour supprimer le secret en dur

---

## Utilisation des URLs Codespaces

Dans GitHub Codespaces, ouvrez l'onglet "Ports".

Vous devez repérer :
- le port 5000 pour l'application Flask
- le port 8200 pour Vault

Pour accéder à l'application dans le navigateur, utilisez l'URL fournie par Codespaces dans cet onglet.

Ne pas utiliser 127.0.0.1 dans le navigateur.

---

## Étape 1 – Vérifier le contenu du projet

Commande à taper :

ls

Cette commande permet d'afficher les fichiers présents dans le projet.

---

## Étape 2 – Démarrer les conteneurs

Commande à taper :

docker compose up -d

Cette commande permet de télécharger les images Docker et de démarrer les services Vault et workspace.

Commande à taper :

docker compose ps

Cette commande permet de vérifier que les conteneurs sont bien démarrés.

---

## Étape 3 – Initialiser Vault

Commande à taper :

docker compose exec vault sh /workspace/vault/init.sh

Cette commande permet :
- de vérifier que Vault fonctionne
- d'activer le moteur de secrets kv-v2
- de créer un secret contenant un identifiant et un mot de passe

---

## Étape 4 – Vérifier le secret dans Vault

Commande à taper :

docker compose exec vault sh -c "export VAULT_ADDR=http://127.0.0.1:8200 && export VAULT_TOKEN=root && vault kv get myapp/database"

Cette commande permet d'afficher toutes les données du secret.

Commande à taper :

docker compose exec vault sh -c "export VAULT_ADDR=http://127.0.0.1:8200 && export VAULT_TOKEN=root && vault kv get -field=password myapp/database"

Cette commande permet d'afficher uniquement le mot de passe.

---

## Étape 5 – Lancer l'application Flask

Commande à taper :

docker compose exec -e VAULT_ADDR=http://vault:8200 -e VAULT_TOKEN=root workspace python app/app.py

Cette commande permet de lancer l'application Flask en la connectant à Vault.

---

## Étape 6 – Tester l'application

Dans le navigateur, à partir de l'URL du port 5000 :

Tester les routes suivantes :

/
insecure
secure

Résultat attendu :
- la route /insecure affiche un mot de passe en clair
- la route /secure récupère le mot de passe depuis Vault

---

## Étape 7 – Appliquer une policy

Commande à taper :

docker compose exec vault sh -c "export VAULT_ADDR=http://127.0.0.1:8200 && export VAULT_TOKEN=root && vault policy write backend-policy /workspace/policies/backend-policy.hcl"

Cette commande permet de créer une policy qui limite les droits d'accès aux secrets.

Commande à taper :

docker compose exec vault sh -c "export VAULT_ADDR=http://127.0.0.1:8200 && export VAULT_TOKEN=root && vault policy read backend-policy"

Cette commande permet de vérifier que la policy a bien été créée.

---

## Étape 8 – Créer un token limité

Commande à taper :

docker compose exec vault sh -c "export VAULT_ADDR=http://127.0.0.1:8200 && export VAULT_TOKEN=root && vault token create -policy=backend-policy -ttl=24h"

Cette commande permet de créer un token avec des droits limités et une durée de vie définie.

---

## Étape 9 – Identifier la faille

Commande à taper :

cat app/app.py

Cette commande permet de lire le code source et de repérer :
- le mot de passe écrit en dur
- la route insecure

---

## Étape 10 – Corriger le code

Action à réaliser :
- supprimer la variable contenant le mot de passe en dur
- modifier la route insecure pour ne plus afficher de secret

---

## Étape 11 – Relancer l'application

Arrêter l'application avec Ctrl + C puis relancer avec :

docker compose exec -e VAULT_ADDR=http://vault:8200 -e VAULT_TOKEN=root workspace python app/app.py

---

## Résultat attendu

À la fin du TP :
- Vault fonctionne correctement
- le secret est stocké dans Vault
- l'application Flask fonctionne
- la route secure utilise Vault
- la route insecure ne contient plus de mot de passe en clair
- une policy a été appliquée
- un token limité a été créé

---

## Conclusion

Ce TP montre qu'un secret ne doit jamais être stocké dans le code.

Vault permet de centraliser et sécuriser les secrets.

L'utilisation de policies permet d'appliquer le principe du moindre privilège.
