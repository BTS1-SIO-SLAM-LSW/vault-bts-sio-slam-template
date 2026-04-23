# Vault BTS SIO SLAM Template

Template GitHub Classroom / repository modèle pour mettre en application la gestion des accès privilégiés (PAM) côté **développement applicatif** avec **HashiCorp Vault Community**.

Ce dépôt est conçu pour des étudiants de **BTS SIO option SLAM**. Il transpose en pratique les points clés du cours :
- ne jamais stocker un secret en dur dans le code ;
- centraliser les secrets dans un coffre ;
- appliquer le principe du moindre privilège via des policies ;
- utiliser des tokens à durée de vie limitée ;
- intégrer la lecture de secrets dans une application Python.

## Objectifs pédagogiques

À l'issue du travail, l'étudiant doit être capable de :
1. démarrer Vault en environnement local ;
2. créer un moteur de secrets KV v2 ;
3. stocker et lire des secrets applicatifs ;
4. écrire une policy HCL limitant les accès ;
5. créer un token limité ;
6. intégrer la lecture d'un secret dans un script Python.

## Compétences BTS SIO mobilisées
- **B1.3** – Gérer le patrimoine informatique
- **B3.2** – Assurer la cybersécurité des services
- **B3.3** – Sécuriser les échanges et les données

## Structure du dépôt

```text
vault-bts-sio-slam-template/
├─ app-python/
│  ├─ app.py
│  ├─ requirements.txt
│  └─ README.md
├─ docs/
│  ├─ sujet.md
│  ├─ corrige-enseignant.md
│  └─ aide-depannage.md
├─ policies/
│  ├─ backend-policy.hcl
│  └─ readonly-policy.hcl
├─ scripts/
│  ├─ start-vault-dev.sh
│  ├─ init-secrets.sh
│  └─ create-limited-token.sh
├─ .github/workflows/
│  └─ secret-scan.yml
├─ .gitignore
└─ README.md
```

## Pré-requis

### Option 1 – Installation locale de Vault
- Windows / Linux / macOS
- Vault CLI installé
- Python 3.10+

### Option 2 – GitHub Codespaces
- ouvrir le dépôt dans Codespaces ;
- exécuter les scripts fournis dans le terminal.

## Démarrage rapide

### 1. Lancer Vault en mode développement

Sous Linux/macOS :

```bash
chmod +x scripts/*.sh
./scripts/start-vault-dev.sh
```

Sous Windows PowerShell, lancez l'équivalent manuellement :

```powershell
$env:VAULT_ADDR='http://127.0.0.1:8200'
$env:VAULT_TOKEN='root'
vault server -dev
```

### 2. Initialiser le coffre et les secrets de démonstration

Dans un second terminal :

```bash
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN='root'
./scripts/init-secrets.sh
```

### 3. Créer une policy limitée et un token temporaire

```bash
./scripts/create-limited-token.sh
```

### 4. Lancer l'application Python

```bash
cd app-python
python -m venv .venv
source .venv/bin/activate  # sous Windows: .venv\Scripts\activate
pip install -r requirements.txt
python app.py
```

## Parcours proposé aux étudiants

### Partie A – Diagnostic
1. Ouvrir `docs/sujet.md`.
2. Identifier pourquoi les secrets en dur sont dangereux.
3. Repérer dans `app-python/app.py` comment le code lit un secret depuis Vault.

### Partie B – Mise en œuvre
1. Démarrer Vault.
2. Créer les secrets `myapp/database` et `myapp/api_keys`.
3. Tester la lecture via CLI.
4. Appliquer la policy `policies/backend-policy.hcl`.
5. Générer un token limité 24 h.
6. Vérifier qu'il ne peut pas lire d'autres chemins.

### Partie C – Analyse de sécurité
1. Expliquer le principe du moindre privilège.
2. Expliquer pourquoi le mode dev n'est pas acceptable en production.
3. Proposer deux améliorations pour une mise en production.

## Livrables attendus
- captures d'écran des commandes réussies ;
- fichier de réponses au format Markdown ou PDF ;
- policy HCL éventuellement modifiée ;
- démonstration du script Python lisant le secret.

## Variables et secrets utilisés dans ce template

Chemins par défaut :
- `myapp/database`
- `myapp/api_keys`
- `myapp/dev`

Clés courantes :
- `username`
- `password`
- `token`
- `url`

## Sécurité et bonnes pratiques rappelées
- ne jamais committer un vrai secret ;
- ne jamais conserver `VAULT_TOKEN=root` dans un fichier ;
- ne pas utiliser le mode dev en production ;
- préférer des tokens à TTL court ;
- documenter les droits réellement nécessaires.

## Pour transformer ce dépôt en template GitHub
1. créer un nouveau dépôt GitHub ;
2. téléverser le contenu de ce dossier ;
3. dans **Settings > General > Template repository**, cocher l'option ;
4. réutiliser le modèle dans GitHub Classroom.
