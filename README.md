
# TP Vault avec GitHub Codespaces – Guide élève (Version détaillée)

## 🎯 Objectif
Comprendre COMMENT sécuriser des secrets avec Vault et POURQUOI chaque commande est utilisée.

---

## ⚠️ IMPORTANT – URLs Codespaces

Dans l’onglet **Ports** :
- Port 5000 → Application Flask
- Port 8200 → Vault

👉 Toujours utiliser les URLs fournies par Codespaces  
❌ Ne jamais utiliser 127.0.0.1 dans le navigateur

---

## 🧪 Étape 1 – Vérifier le projet

Commande :
    ls

👉 Sert à afficher les fichiers présents dans le projet

---

## 🧪 Étape 2 – Démarrer les conteneurs

Commande :
    docker compose up -d

👉 Sert à :
- télécharger les images Docker
- démarrer Vault et l’environnement Python

Commande :
    docker compose ps

👉 Sert à vérifier que les services sont bien démarrés

---

## 🧪 Étape 3 – Initialiser Vault

Commande :
    docker compose exec vault sh /workspace/vault/init.sh

👉 Sert à :
- se connecter à Vault
- activer le stockage de secrets (kv-v2)
- créer un premier secret (database)

---

## 🧪 Étape 4 – Vérifier le secret

Commande :
    docker compose exec vault sh -c "export VAULT_ADDR=http://127.0.0.1:8200 && export VAULT_TOKEN=root && vault kv get myapp/database"

👉 Sert à :
- récupérer toutes les informations du secret

Commande :
    docker compose exec vault sh -c "export VAULT_ADDR=http://127.0.0.1:8200 && export VAULT_TOKEN=root && vault kv get -field=password myapp/database"

👉 Sert à :
- récupérer uniquement le mot de passe

---

## 🧪 Étape 5 – Lancer Flask

Commande :
    docker compose exec -e VAULT_ADDR=http://vault:8200 -e VAULT_TOKEN=root workspace python app/app.py

👉 Sert à :
- lancer l’application Flask
- connecter l’application à Vault

---

## 🧪 Étape 6 – Tester l’application

Dans le navigateur (via Ports) :

- /insecure → montre un mot de passe en clair ❌
- /secure → utilise Vault ✔

---

## 🧪 Étape 7 – Appliquer une policy

Commande :
    docker compose exec vault sh -c "export VAULT_ADDR=http://127.0.0.1:8200 && export VAULT_TOKEN=root && vault policy write backend-policy /workspace/policies/backend-policy.hcl"

👉 Sert à :
- définir les droits d’accès (lecture seule)

Commande :
    docker compose exec vault sh -c "export VAULT_ADDR=http://127.0.0.1:8200 && export VAULT_TOKEN=root && vault policy read backend-policy"

👉 Sert à vérifier la policy

---

## 🧪 Étape 8 – Créer un token sécurisé

Commande :
    docker compose exec vault sh -c "export VAULT_ADDR=http://127.0.0.1:8200 && export VAULT_TOKEN=root && vault token create -policy=backend-policy -ttl=24h"

👉 Sert à :
- créer un accès limité
- appliquer le principe du moindre privilège

---

## 🧪 Étape 9 – Identifier la faille

Commande :
    cat app/app.py

👉 Sert à lire le code et repérer :
- le mot de passe en dur
- la route insecure

---

## 🧪 Étape 10 – Corriger le code

Action :
- supprimer DB_PASSWORD
- ne plus afficher de secret

---

## 🎯 Résultat attendu

- Vault fonctionne
- Flask fonctionne
- /secure utilise Vault
- /insecure corrigé
- policy appliquée
- token sécurisé créé

---

## 🧠 À retenir

- un secret ne doit jamais être dans le code
- Vault protège les secrets
- une policy limite les accès
- Codespaces utilise des URLs dynamiques
